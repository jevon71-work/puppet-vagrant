# Defined type for creating virtual user accounts
#
define testenv_users::virtual ($uid,$realname,$pass) {

  user { $title:
    ensure     =>  'present',
    uid        =>  $uid,
    gid        =>  $title,
    shell      =>  '/bin/bash',
    home       =>  "/home/${title}",
    comment    =>  $realname,
    password   =>  $pass,
    managehome =>  true,
    require    =>  Group[$title],
  }

  group { $title:
    gid               =>  $uid,
  }

  file { "/home/${title}":
    ensure  =>  directory,
    owner   =>  $title,
    group   =>  $title,
    mode    =>  '0700',
    require =>  [ User[$title], Group[$title] ],
  }
}
