# site.pp - main target(s)

node 'puppet.vm.vagrant' {
  include debugging
}

node /solr0/ {
  notify {"hello solr nodes!":}
  include jayeola-solr
}
