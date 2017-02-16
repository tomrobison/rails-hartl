pkg_name=nio4r
pkg_version=0.0.1
pkg_origin=tomrobison
pkg_maintainer="Tom Robison <thomas.robison@gmail.com>"
pkg_license=('mit')
pkg_source="no_download"

pkg_deps=(
  core/bundler
  core/ruby
  core/sqlite
)

pkg_build_deps=(
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
  local _bundler_dir=$(pkg_path_for bundler)

  local _sqlite_dir=$(pkg_path_for sqlite)

  export GEM_HOME=${pkg_prefix}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

   bundle config build.sqlite3 --with-sqlite3-dir="${_sqlite_dir}"

  # The mytutorialapp source code is in a relative directory, so you must copy the
  # contents of the source directory into your $HAB_CACHE_SRC_PATH/$pkg_dirname as this 
  # is the same path that Habitat would use if you downloaded a tarball of the source code.
  cp -vr $PLAN_CONTEXT/../../bundler/sqlite.gemfile $HAB_CACHE_SRC_PATH/$pkg_dirname/Gemfile

  bundle install --jobs 2 --retry 5 --path vendor/bundle --binstubs
}

do_install() {
  return 0
}