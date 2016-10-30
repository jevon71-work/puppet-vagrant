$packagelist = ['screen', 'python34', 'git', 'bash-completion', 'unzip', 'wget', 'tree', 'ansible']
$workstation_username = pick(hiera('setup_workstation::username'), 'dummy')
$workstation_user_fullname = pick(hiera('setup_workstation::user_fullname'), 'You have not specified your common.yaml')
$user_sshkeys = pick(hiera('setup_workstation::user_sshkeys'), 'ssh-rsa This will never work')
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

accounts::user {$workstation_username:
  uid     => '5001',
  gid     => '5001',
  comment => $workstation_user_fullname,
  sshkeys => [$user_sshkeys],
}

accounts::user {'puppet':
  uid => '501',
  gid => '501',
}

file { "/home/${workstation_username}/.ssh/id_rsa":
  ensure  => 'present',
  source  => '/tmp/vagrant-puppet/environments/testenv/modules/id_rsa.erb',
  owner   => $workstation_username,
  mode    => '0400',
  require => Accounts::User[$workstation_username],
}

file { "/etc/sudoers.d/${workstation_username}":
  ensure  => 'file',
  content => "Defaults:${workstation_username} !requiretty\n${workstation_username} ALL=(ALL) NOPASSWD: ALL\n",
  group   => 'root',
  mode    => '0440',
  owner   => 'root',
  require => Accounts::User[$workstation_username],
}

file { "/home/${workstation_username}/.bash_profile":
  ensure  => present,
  require => Accounts::User[$workstation_username],
}

file_line { "extend_${workstation_username}_path_to_include_Terraform":
  path    => "/home/${workstation_username}/.bash_profile",
  line    => 'export PATH=/opt/terraform:$PATH',
  require => [File["/home/${workstation_username}/.bash_profile"], File['/opt/terraform/terraform']],
}

file { "/home/${workstation_username}/.ssh/known_hosts":
  ensure  => 'file',
  source  => 'puppet:///modules/setup_workstation/known_hosts',
  mode    => '0644',
  owner   => $workstation_username,
  group   => $workstation_username,
  require => Accounts::User[$workstation_username],
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

staging::file { 'terragrunt_linux_amd64':
  source  => 'https://github.com/gruntwork-io/terragrunt/releases/download/v0.1.3/terragrunt_linux_amd64',
  require => Accounts::User['puppet'],
}

file { '/opt/terraform/terraform':
  ensure  => 'link',
  target  => '/opt/terraform/ver_0.6.16/terraform',
  require => Staging::Extract['terraform_0.6.16_linux_amd64.zip'],
}

vcsrepo { "/home/${workstation_username}/awssaml":
  ensure   => 'latest',
  provider => 'git',
  source   => 'git@github.com:DiceHoldingsInc/awssaml.git',
  revision => 'master',
  user     => $workstation_username,
  require  => [Accounts::User[$workstation_username], Package['git'], File["/home/${workstation_username}/.ssh/known_hosts"]],
}

include pip

pip::install { 'awscli':
  python_version => '3.4',
}

file { "/home/${workstation_username}/.aws":
  ensure  => 'directory',
  owner   => $workstation_username,
  group   => $workstation_username,
  mode    => '0775',
  require => Accounts::User[$workstation_username],
}

file { "/home/${workstation_username}/.aws/config":
  ensure  => 'file',
  owner   => $workstation_username,
  group   => $workstation_username,
  mode    => '0664',
  content => "[default]\nregion = us-east-1\noutput = json\n\n",
}

file { "/home/${workstation_username}/.aws/credentials":
  ensure  => 'file',
  owner   => $workstation_username,
  group   => $workstation_username,
  mode    => '0664',
  content => "[default]\naws_secret_access_key = Default\naws_secret_key_id = Default\n\n",
}
# exec { 'check_awssaml_presence':
#   command => '/bin/false',
#   unless  => 'usr/bin/test -e /usr/bin/awssaml',
# }
#
pip::install { 'awssaml':
  package        => "/home/${workstation_username}/awssaml/.",
  python_version => '3.4',
  require        => [Pip::Install['awscli'], Vcsrepo["/home/${workstation_username}/awssaml"]],
}
