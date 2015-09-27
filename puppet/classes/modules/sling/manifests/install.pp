class sling::install inherits ::sling {

  if $::sling::manage_user {
    user { $::sling::user:
      ensure  => present,
      system => true,
      gid => $::sling::group,
      require => Group[$::sling::group],
      before => File[$lib_path]
    }

    group { $::sling::group:
      ensure => present,
    }
  }

  file {$lib_path:
    ensure => directory,
    owner => $::sling::user,
    group => $::sling::group,
  } ->

  wget::fetch { 'Download Sling Standalone Jar':
    source => $::sling::standalone_jar,
    destination => $jar_path,
    user => $::sling::user,
    timeout => 30,
    verbose => false,
    before => Service['sling'],
  }

  case $service_provider {
    'systemd': {
      include sling::install::systemd
    }
  }

  service { 'sling':
    ensure => $::sling::ensure,
    hasstatus => true,
    hasrestart => true,
    provider => $service_provider,
  } ->

  file { '/var/log/sling':
    ensure => link,
    target => "${lib_path}/sling/logs",
    require => Service['sling'],
  }

}
