$packagelist = ['screen', 'python34', 'git']

file { '/tmp/testfile.txt':
  ensure  => 'file',
  content => "The Matrix Has You\nFollow The White Rabbit\n",
  group   => 'vagrant',
  mode    => '0664',
  owner   => 'vagrant',
}

user { 'jevonw':
  ensure => 'present',
  groups => ['wheel'],
  home   => '/home/jevonw',
  shell  => '/bin/bash',
  uid    => '5001',
}

Package {ensure => 'latest'}

package {$packagelist:}

file { '/home/jevonw/.ssh/id_rsa':
  ensure  => 'present',
  source  => 'puppet://id_rsa.erb',
  owner   => 'jevonw',
  mode    => '0400',
  require => User ['jevonw'],
}
