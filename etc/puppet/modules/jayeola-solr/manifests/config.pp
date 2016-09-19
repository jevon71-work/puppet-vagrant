# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html
# Class: solr::config

# use this class to __configure__ what you want

Class solr::config inherits solr {
  file { '/etc/solr.conf':
    ensure  => file,
    owner   => 'root',
    gropup  => 'root',
    mode    => '0644',
    content =>  template($module_name/ntp.conf.erb),
  }
    
}
