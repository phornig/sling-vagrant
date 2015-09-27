class sling (
  $version = $::sling::params::version,
  $standalone_jar = $::sling::params::standalone_jar,
  $manage_user = true,
  $user = $::sling::params::user,
  $group = $::sling::params::group,
  $ensure = running,
  $debug = false,
  $debug_port = 30303
) inherits ::sling::params {

  include ::sling::install

}
