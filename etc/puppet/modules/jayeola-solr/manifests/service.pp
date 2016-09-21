# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html

# === Class: solr::service

class jayeola-solr::service inherits jayeola-solr {
  service { 'solr':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    require     => Package['tomcat6']
    # pattern => 'tomcat6',
  }
}
