pkg_name=nokogiri
pkg_version=0.0.1
pkg_origin=tomrobison
pkg_maintainer="Tom Robison <thomas.robison@gmail.com>"
pkg_license=('mit')
pkg_source="no_download"

pkg_deps=(
  core/bundler
  core/libxml2
  core/libxslt
  core/ruby
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)

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
  return 0
}

do_build() {
  export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"

  local _bundler_dir=$(pkg_path_for bundler)
  local _libxml2_dir=$(pkg_path_for libxml2)
  local _libxslt_dir=$(pkg_path_for libxslt)
  local _zlib_dir=$(pkg_path_for zlib)

  export GEM_HOME=${pkg_prefix}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

  # don't let bundler split up the nokogiri config string (it breaks
  # the build), so specify it as an env var instead
  export NOKOGIRI_CONFIG="--use-system-libraries --with-zlib-dir=${_zlib_dir} --with-xslt-dir=${_libxslt_dir} --with-xml2-include=${_libxml2_dir}/include/libxml2 --with-xml2-lib=${_libxml2_dir}/lib"

  # The mytutorialapp source code is in a relative directory, so you must copy the
  # contents of the source directory into your $HAB_CACHE_SRC_PATH/$pkg_dirname as this 
  # is the same path that Habitat would use if you downloaded a tarball of the source code.
  cp -vr $PLAN_CONTEXT/../../bundler/nokogiri.gemfile $HAB_CACHE_SRC_PATH/$pkg_dirname/Gemfile

  bundle install --jobs 2 --retry 5 --path vendor/bundle --binstubs
}

do_install() {
  return 0
}