file { '/tmp/testfile.txt':
  ensure  => 'file',
  content => "The Matrix Has You\nFollow The White Rabbit\n",
  group   => 'vagrant',
  mode    => '0664',
  owner   => 'vagrant',
}

user { 'jevonw':
  ensure => 'present',
  gid    => '5001',
  groups => ['wheel'],
  home   => '/home/jevonw',
  shell  => '/bin/bash',
  uid    => '5001',
}
