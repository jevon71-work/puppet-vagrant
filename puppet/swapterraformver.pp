accounts::user {'puppet':
  uid => '501',
  gid => '501',
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

file { '/opt/terraform/terraform-new':
  ensure => 'link',
  target => '/opt/terraform/ver_0.7.13/terraform',
  # require => Staging::Extract['terraform_0.7.13_linux_amd64.zip'],
}

file { '/opt/terraform/terraform':
  ensure => 'link',
  target => '/opt/terraform/ver_0.7.13/terraform',
  # require => Staging::Extract['terraform_0.7.13_linux_amd64.zip'],
}

file { '/opt/terraform/ver_0.6.16':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

file { '/opt/terraform/terraform-old':
  ensure => 'link',
  target => '/opt/terraform/ver_0.6.16/terraform',
  # require => Staging::Extract['terraform_0.6.16_linux_amd64.zip'],
}
