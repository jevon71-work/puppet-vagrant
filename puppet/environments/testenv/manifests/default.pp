$base_packagelist = ['vim', 'screen', 'git', 'bash-completion', 'unzip', 'wget', 'tree', 'telnet', 'traceroute', 'lsof', 'nmap', 'rake', 'ruby-devel']
$os_spec_packagelist = $facts['osfamily'] ? {
  'redhat' => ['python34', 'ansible', 'bind-utils', 'python34-devel', 'python-devel', 'openssl-devel'],
  'debian' => ['dnsutils'],
  default  => ['WhatWereYouThinking?ThisCannotRunOnThisOS'],
}
$gem_packagelist = ['bundler', 'r10k', 'test-kitchen', 'kitchen-puppet']
$setup_workstation_username = hiera('setup_workstation_username', 'dummy')
$setup_workstation_user_fullname = hiera('setup_workstation_user_fullname', 'You have not specified your common.yaml')
$setup_workstation_user_sshkeys = hiera('setup_workstation_user_sshkeys', 'ssh-rsa This will never work')

file { '/tmp/testfile.txt':
  ensure  => 'file',
  content => "The Matrix Has You\nFollow The White Rabbit\n",
  group   => 'vagrant',
  mode    => '0664',
  owner   => 'vagrant',
}

Package {ensure => 'latest'}

package {$base_packagelist:}

package {$os_spec_packagelist:}

package { $gem_packagelist:
  provider => gem,
}

accounts::user {$setup_workstation_username:
  uid     => '5001',
  gid     => '5001',
  comment => $setup_workstation_user_fullname,
  sshkeys => [$setup_workstation_user_sshkeys],
}

accounts::user {'puppet':
  uid => '501',
  gid => '501',
}

file { "/home/${setup_workstation_username}/.ssh/id_rsa":
  ensure  => 'present',
  source  => '/tmp/vagrant-puppet/environments/testenv/modules/id_rsa.erb',
  owner   => $setup_workstation_username,
  mode    => '0400',
  require => Accounts::User[$setup_workstation_username],
}

file { "/etc/sudoers.d/${setup_workstation_username}":
  ensure  => 'file',
  content => "Defaults:${setup_workstation_username} !requiretty\n${setup_workstation_username} ALL=(ALL) NOPASSWD: ALL\n",
  group   => 'root',
  mode    => '0440',
  owner   => 'root',
  require => Accounts::User[$setup_workstation_username],
}

file { "/home/${setup_workstation_username}/.bash_profile":
  ensure  => present,
  require => Accounts::User[$setup_workstation_username],
}

file_line { "extend_${setup_workstation_username}_path_to_include_Terraform_and_Terragrunt":
  path    => "/home/${setup_workstation_username}/.bash_profile",
  line    => 'export PATH=/opt/terraform:/opt/terragrunt:$PATH',
  require => [File["/home/${setup_workstation_username}/.bash_profile"], File['/opt/terraform/terraform'], File['/opt/terragrunt/terragrunt']],
}

file_line { 'allow_ipv4_forwarding':
  path   => '/etc/sysctl.conf',
  line   => 'net.ipv4.ip_forward = 1',
  notify => Service['docker'],
}

file { "/home/${setup_workstation_username}/.ssh/known_hosts":
  ensure  => 'file',
  source  => 'puppet:///modules/setup_workstation/known_hosts',
  mode    => '0644',
  owner   => $setup_workstation_username,
  group   => $setup_workstation_username,
  require => Accounts::User[$setup_workstation_username],
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

file { '/opt/terraform/ver_0.7.13':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

staging::file { 'terraform_0.7.13_linux_amd64.zip':
  source  => 'https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_linux_amd64.zip',
  require => [Accounts::User['puppet'], File['/opt/terraform/ver_0.7.13']],
}

staging::extract { 'terraform_0.7.13_linux_amd64.zip':
  target  => '/opt/terraform/ver_0.7.13',
  creates => '/opt/terraform/ver_0.7.13/terraform',
  require => Staging::File['terraform_0.7.13_linux_amd64.zip'],
}

file { '/opt/terraform/terraform-new':
  ensure  => 'link',
  target  => '/opt/terraform/ver_0.7.13/terraform',
  require => Staging::Extract['terraform_0.7.13_linux_amd64.zip'],
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

staging::file { 'terragrunt_linux_amd64':
  source  => 'https://github.com/gruntwork-io/terragrunt/releases/download/v0.1.3/terragrunt_linux_amd64',
  require => Accounts::User['puppet'],
}

file { '/opt/terragrunt':
  ensure => directory,
  mode   => '0755',
}

file { '/opt/terragrunt/ver_0.1.3':
  ensure => directory,
  mode   => '0755',
}

file { '/opt/terragrunt/ver_0.1.3/terragrunt':
  ensure  => file,
  source  => '/var/staging/terragrunt_linux_amd64',
  mode    => '0755',
  require => Staging::File['terragrunt_linux_amd64'],
}

file { '/opt/terragrunt/terragrunt':
  ensure  => link,
  target  => '/opt/terragrunt/ver_0.1.3/terragrunt',
  require => File['/opt/terragrunt/ver_0.1.3/terragrunt'],
}

vcsrepo { "/home/${setup_workstation_username}/awssaml":
  ensure   => 'latest',
  provider => 'git',
  source   => 'git@github.com:DiceHoldingsInc/awssaml.git',
  revision => 'master',
  user     => $setup_workstation_username,
  require  => [Accounts::User[$setup_workstation_username], Package['git'], File["/home/${setup_workstation_username}/.ssh/known_hosts"]],
}

include pip

pip::install { 'awscli':
  python_version => '3.4',
}

file { "/home/${setup_workstation_username}/.aws":
  ensure  => 'directory',
  owner   => $setup_workstation_username,
  group   => $setup_workstation_username,
  mode    => '0775',
  require => Accounts::User[$setup_workstation_username],
}

file { "/home/${setup_workstation_username}/.aws/config":
  ensure  => 'file',
  owner   => $setup_workstation_username,
  group   => $setup_workstation_username,
  mode    => '0664',
  content => "[default]\nregion = us-east-1\noutput = json\n\n",
}

file { "/home/${setup_workstation_username}/.aws/credentials":
  ensure  => 'file',
  owner   => $setup_workstation_username,
  group   => $setup_workstation_username,
  mode    => '0664',
  content => "[default]\naws_secret_access_key = Default\naws_secret_key_id = Default\n\n",
}
# exec { 'check_awssaml_presence':
#   command => '/bin/false',
#   unless  => 'usr/bin/test -e /usr/bin/awssaml',
# }
#
pip::install { 'awssaml':
  package        => "/home/${setup_workstation_username}/awssaml/.",
  python_version => '3.4',
  require        => [Pip::Install['awscli'], Vcsrepo["/home/${setup_workstation_username}/awssaml"]],
}

if $facts['osfamily'] == 'redhat' {
  yumrepo { 'dockerrepo':
    descr    => 'Docker Repository',
    enabled  => 1,
    baseurl  => 'https://yum.dockerproject.org/repo/main/centos/7/',
    gpgcheck => 1,
    gpgkey   => 'https://yum.dockerproject.org/gpg',
  }
  package { 'docker-engine':
    ensure  => latest,
    notify  => Service['docker'],
    require => Yumrepo['dockerrepo'],
  }
  service { 'docker':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['docker-engine'],
    # pattern => 'docker-engine',
  }
  # staging::file { 'vagrant_1.9.0_x86_64.rpm':
  #   source  => 'https://releases.hashicorp.com/vagrant/1.9.0/vagrant_1.9.0_x86_64.rpm',
  #   require => Accounts::User['puppet'],
  # }
  wget::fetch { 'vagrant_1.9.0':
    source      => 'https://releases.hashicorp.com/vagrant/1.9.0/vagrant_1.9.0_x86_64.rpm',
    destination => '/tmp/',
    cache_dir   => '/var/staging',
    timeout     => 0,
    verbose     => false,
    # source_hash => '9bb8713bca36eb1f3e85d1d9bbaf6d3b',
  }
  package { 'vagrant':
    ensure   => installed,
    provider => rpm,
    source   => '/tmp/vagrant_1.9.0_x86_64.rpm',
    require  => Wget::Fetch['vagrant_1.9.0'],
  }
}
