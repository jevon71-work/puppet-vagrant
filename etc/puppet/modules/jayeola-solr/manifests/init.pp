# == Class: jayeola-solr
# This is hte main jayeola-solr class
#
# === Parameters
# - $my_solr_version
# - $my_solr_url
# - $my_solr_dest_dir
# - $my_solr_user
# - $my_solr_group


# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'jayeola-solr':
#    my_solr_version => version,
#  }
#
# === Authors
#
# John Maclean jayeola >at< gmail d>o<t com
#
# === Copyright
#
# Copyright 2016 jayeola.
#
class jayeola-solr {
  include jayeola-solr::install
  include jayeola-solr::config
}
