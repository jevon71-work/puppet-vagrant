# site.pp - main target(s)

node 'puppet.vm.vagrant' {
  include debugging
}

node /solr0/ {
  notify {"helo solr nodes!":}
  include solr
}

node /zk0/ {
  notify {"hello zk nodes!":}
}
