# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html

# === Class: solr::install

# use this class to install what you need to...
Class solr::install inherits solr {
  package {  'solr':
    ensure => installed,}
  }
}
