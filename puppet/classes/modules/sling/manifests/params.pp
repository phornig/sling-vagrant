class sling::params {

  $version = '7'
  $standalone_jar = "ftp://ftp.fu-berlin.de/unix/www/apache/sling/org.apache.sling.launchpad-${version}-standalone.jar"

  $user = 'sling'
  $group = 'sling'

  if $::osfamily == 'RedHat' {
    $lib_path = '/var/lib/sling'
    $jar_path = "${lib_path}/org.apache.sling.launchpad-${version}-standalone.jar"
    $service_provider = 'systemd'

    $service_file_path = '/etc/systemd/system/multi-user.target.wants/sling.service'
  }

}
