$packagelist = ['screen', 'python34', 'git', 'bash-completion', 'unzip', 'wget', 'tree']

# mod ('puppet-staging', '2.0.1')
# mod ('puppetlabs-accounts', '1.1.0')
# mod ('puppetlabs-stdlib', '4.13.1')

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

accounts::user {'puppet':
  uid => '501',
  gid => '501',
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
  require => Accounts::User['jevonw'],
}

file { '/home/jevonw/.bash_profile':
  ensure  => present,
  require => Accounts::User['jevonw'],
}

file_line { 'extend_jevonw_path_to_include_Terraform':
  path    => '/home/jevonw/.bash_profile',
  line    => 'export PATH=/opt/terraform:$PATH',
  require => [File['/home/jevonw/.bash_profile'], File['/opt/terraform/terraform']],
}

file { '/home/jevonw/.ssh/known_hosts':
  ensure  => 'file',
  source  => 'puppet:///modules/setup_workstation/known_hosts',
  mode    => '0644',
  owner   => 'jevonw',
  group   => 'jevonw',
  require => Accounts::User['jevonw'],
}

class { 'staging':
  path  => '/var/staging',
  owner => 'puppet',
  group => 'puppet',
}

file { '/opt/terraform':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

file { '/opt/terraform/ver_0.7.7':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

staging::file { 'terraform_0.7.7_linux_amd64.zip':
  source  => 'https://releases.hashicorp.com/terraform/0.7.7/terraform_0.7.7_linux_amd64.zip',
  require => [Accounts::User['puppet'], File['/opt/terraform/ver_0.7.7']],
}

staging::extract { 'terraform_0.7.7_linux_amd64.zip':
  target  => '/opt/terraform/ver_0.7.7',
  creates => '/opt/terraform/ver_0.7.7/terraform',
  require => Staging::File['terraform_0.7.7_linux_amd64.zip'],
}

file { '/opt/terraform/terraform-new':
  ensure  => 'link',
  target  => '/opt/terraform/ver_0.7.7/terraform',
  require => Staging::Extract['terraform_0.7.7_linux_amd64.zip'],
}

file { '/opt/terraform/ver_0.6.16':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

staging::file { 'terraform_0.6.16_linux_amd64.zip':
  source  => 'https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip',
  require => [Accounts::User['puppet'], File['/opt/terraform/ver_0.6.16']],
}

staging::extract { 'terraform_0.6.16_linux_amd64.zip':
  target  => '/opt/terraform/ver_0.6.16',
  creates => '/opt/terraform/ver_0.6.16/terraform',
  require => Staging::File['terraform_0.6.16_linux_amd64.zip'],
}

file { '/opt/terraform/terraform':
  ensure  => 'link',
  target  => '/opt/terraform/ver_0.6.16/terraform',
  require => Staging::Extract['terraform_0.6.16_linux_amd64.zip'],
}

vcsrepo { '/home/jevonw/awssaml':
  ensure   => 'latest',
  provider => 'git',
  source   => 'git@github.com:DiceHoldingsInc/awssaml.git',
  revision => 'master',
  user     => 'jevonw',
  require  => [Accounts::User['jevonw'], Package['git'], File['/home/jevonw/.ssh/known_hosts']],
}
