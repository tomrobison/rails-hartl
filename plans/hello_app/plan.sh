pkg_name=hello_app
pkg_version=0.0.1
pkg_origin=tomrobison
pkg_maintainer="Tom Robison <thomas.robison@gmail.com>"
pkg_license=('mit')
pkg_source="no_download"

pkg_deps=(
  core/bundler
  core/cacerts
  core/glibc
  core/libffi
  core/libxml2
  core/libxslt
  core/libyaml
  core/node
  core/sqlite
  core/ruby
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)

pkg_svc_user="root"
pkg_svc_group=$pkg_svc_user

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_expose=(3000)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  build_line "Setting link for /usr/bin/env to 'coreutils'"
  [[ ! -f /usr/bin/env ]] && ln -s "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  return 0
}

do_build() {
  export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"

  local _bundler_dir=$(pkg_path_for bundler)

  local _libxml2_dir=$(pkg_path_for libxml2)
  local _libxslt_dir=$(pkg_path_for libxslt)
  local _zlib_dir=$(pkg_path_for zlib)

  local _sqlite_dir=$(pkg_path_for sqlite)

  export GEM_HOME=${pkg_prefix}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

  # don't let bundler split up the nokogiri config string (it breaks
  # the build), so specify it as an env var instead
  export NOKOGIRI_CONFIG="--use-system-libraries --with-zlib-dir=${_zlib_dir} --with-xslt-dir=${_libxslt_dir} --with-xml2-include=${_libxml2_dir}/include/libxml2 --with-xml2-lib=${_libxml2_dir}/lib"

  # we control the variable above, and it will be all on one line, and
  # we need single quotes otherwise the extconf doesn't build the
  # extension.
  bundle config build.nokogiri '${NOKOGIRI_CONFIG}'
  bundle config build.sqlite3 --with-sqlite3-dir="${_sqlite_dir}"

  # The mytutorialapp source code is in a relative directory, so you must copy the
  # contents of the source directory into your $HAB_CACHE_SRC_PATH/$pkg_dirname as this 
  # is the same path that Habitat would use if you downloaded a tarball of the source code.
  cp -vr $PLAN_CONTEXT/../../hello_app/* $HAB_CACHE_SRC_PATH/$pkg_dirname/

  # We need to add tzinfo-data to the Gemfile since we're not in an
  # environment that has this from the OS
  if ! grep -q 'gem .*tzinfo-data.*' Gemfile; then
    echo 'gem "tzinfo-data"' >> Gemfile
  fi

  # Remove the specific ruby version, because our ruby is 2.3
  sed -e 's/^ruby.*//' -i Gemfile

  bundle install --jobs 2 --retry 5 --path vendor/bundle --binstubs
}

do_install() {
  cp -R . "${pkg_prefix}/static"

  for binstub in ${pkg_prefix}/static/bin/*; do
    build_line "Setting shebang for ${binstub} to 'ruby'"
    [[ -f $binstub ]] && sed -e "s#/usr/bin/env ruby#$(pkg_path_for ruby)/bin/ruby#" -i "$binstub"
  done

  if [[ $(readlink /usr/bin/env) = "$(pkg_path_for coreutils)/bin/env" ]]; then
    build_line "Removing the symlink we created for '/usr/bin/env'"
    rm /usr/bin/env
  fi
}
