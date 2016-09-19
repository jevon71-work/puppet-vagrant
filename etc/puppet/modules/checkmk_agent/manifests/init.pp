# Class: checkmk_agent
# ===========================
#
# Full description of class checkmk_agent here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'checkmk_agent':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#

# modules/checkmk_agent/manifests/init.pp
class checkmk_agent {

  package { 'xinetd':
    ensure => installed,
  }

  file { '/etc/xinetd.d/check_mk':
    source     => 'puppet:///modules/checkmk_agent/check_mk',
    owner      => 'root',
    group      => 'root',
    mode       => '640',
    notify     => Service['xinetd'],
    require    => Package['xinetd']
  }

  service {'xinetd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  file {'/tmp/check-mk-agent_1.2.4p5-2_all.deb':
    ensure    => present,
    source    => "puppet:///modules/checkmk_agent/check-mk-agent_1.2.4p5-2_all.deb",
  }

  package { 'check-mk-agent':
    ensure    => installed,
    provider  => 'dpkg',
    source    => "/tmp/check-mk-agent_1.2.4p5-2_all.deb",
  }

}
