class site::role::sling_server () {
  info('Applying role "Sling Server"')

  include site::profile::maven
  include site::profile::sling
}