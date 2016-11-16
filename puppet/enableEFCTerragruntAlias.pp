$setup_workstation_username = hiera('setup_workstation_username', 'dummy')
$setup_workstation_user_fullname = hiera('setup_workstation_user_fullname', 'You have not specified your common.yaml')
$setup_workstation_user_sshkeys = hiera('setup_workstation_user_sshkeys', 'ssh-rsa This will never work')

accounts::user {$setup_workstation_username:
  uid     => '5001',
  gid     => '5001',
  comment => $setup_workstation_user_fullname,
  sshkeys => [$setup_workstation_user_sshkeys],
}

file { "/home/${setup_workstation_username}/.bash_profile":
  ensure  => present,
  require => Accounts::User[$setup_workstation_username],
}

file_line { "add_Terragrunt_alias_to_${setup_workstation_username}":
  path    => "/home/${setup_workstation_username}/.bash_profile",
  line    => 'alias terragrunt=\'AWS_PROFILE=efcprodaws terragrunt\'',
  require => File["/home/${setup_workstation_username}/.bash_profile"],
}
