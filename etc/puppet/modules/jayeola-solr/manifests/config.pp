# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html
# Class: solr::config
#
# set up the solr version X installation

#
#  === Actionz
#  - create java symlink for tomcat

class jayeola-solr::config inherits jayeola-solr {

  if $::operatingsystem == 'Ubuntu' {
    file {'/usr/java':
      ensure => directory,
    }

    file { '/usr/lib/jvm/java-7-openjdk-amd64':
      ensure => 'symlink',
      target => "/usr/java/default",
      force  => true,
    }
  }
}
