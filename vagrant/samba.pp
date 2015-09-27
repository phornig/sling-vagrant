class {'samba::server':
  workgroup => 'PIXELPARK',
  server_string => "VM Samba",
}

samba::server::share {'vm-share':
  comment => 'VM Share',
  path => '/',
  guest_ok => true,
  browsable => true,
  read_only => false,
  force_user => 'vagrant',
  force_group => 'vagrant',
}

user {'vagrant':}

samba::server::user {'vagrant':
  password => 'vagrant'
}