# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html

# === Class: solr::service

class slr::service inherits solr {
  service { 'solr':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    require     => Package['solr']
    # pattern => 'solr',
  }
}
