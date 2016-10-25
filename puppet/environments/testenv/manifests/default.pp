$packagelist = ['screen', 'python34', 'git']

file { '/tmp/testfile.txt':
  ensure  => 'file',
  content => "The Matrix Has You\nFollow The White Rabbit\n",
  group   => 'vagrant',
  mode    => '0664',
  owner   => 'vagrant',
}

Package {ensure => 'latest'}

package {$packagelist:}

accounts::user {'jevonw':
  uid     => '5001',
  gid     => '5001',
  comment => 'Jevon White',
  sshkeys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDixR0VNYqZe1ShlNB1ShHBlYo0I8pPUjUZ+orfdlIrYadXnF2dbXaKqrMEZMW92L687vUZteRvxuzgxJXHxmjkI3ck+C3uqFaxPPjykUKYfBXKNuR1LGBOT9F0jpv/R0k271fizf51NQnb0EPYyWaX+oh004mSIpj0K5KJur8gyP2ABe6zKTQCljNaeAmxQCOasqnsMko/5JuSUQV4ooSPYs/kHe0XwNWt4aNlwwwbM5vz5VwKdK9Jyn8gMMUx2eKeBr+hImzVfTrhulkX45HSrdk+WrxE7gsvm1i/wFTEZ2kBiC1sC1jNBazr1T5+DTJQ9wth10EWSBOsy7N9oghNbO7Qrj7NJ9wUBJ57gqXU0aGHphshAhD9xur2CfCXG+dZcFRCVKSQuZJCKt+SA4CHLVILbsvfEU2MtSH571Cmx7m8V0UppRo4ZxH+1JbHfKiO54+x7sVAen9zkK5CwTlKoadOHHkGFKVwFtuZbTNSNFVciZ/bXqJ3opELqos5llZJGdyb9RWNWUbTtyqqr492L4AqcWofYeiKONylyQZILo26wHtw/n+ERfzKC9wswEKFeq7Pm7TNa/9X9tsVCbPVmjGXdpxWODrwrbV7KT/ZGFzuQ30x+NdDRAk3AjY98rJWchBGUoXLSjBLiWLMegs3IhcLR7s1GOFSPiQ43fxlQQ== jevon.white@dhigroupinc.com'],
}

file { '/home/jevonw/.ssh/id_rsa':
  ensure  => 'present',
  source  => '/tmp/vagrant-puppet/environments/testenv/modules/id_rsa.erb',
  owner   => 'jevonw',
  mode    => '0400',
  require => Accounts::User['jevonw'],
}

file { '/etc/sudoers.d/jevonw':
  ensure  => 'file',
  content => "Defaults:jevonw !requiretty\njevonw ALL=(ALL) NOPASSWD: ALL\n",
  group   => 'root',
  mode    => '0440',
  owner   => 'root',
}
