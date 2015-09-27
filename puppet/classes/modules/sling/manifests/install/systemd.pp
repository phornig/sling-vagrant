class sling::install::systemd inherits ::sling {

  $user = $::sling::user

  file { 'systemd script':
    ensure => file,
    path => $::sling::params::service_file_path,
    content => template('sling/systemd.erb'),
  } ->

  exec { "systemd_reload_sling":
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
    subscribe => File['systemd script'],
    before => Service['sling'],
  }

}
