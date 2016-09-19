# Class: checkmk_host
# ===========================
#
# Full description of class checkmk_host here.
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
#    class { 'checkmk_host':
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

class checkmk_host {

  $my_deps= ['apache2', 'apache2-bin', 'apache2-data', 'apache2-mpm-prefork',
    'apache2-utils', 'curl', 'debugedit', 'dialog', 'fontconfig',
     'fontconfig-config', 'fonts-dejavu-core', 'fonts-liberation',
      'fping', 'graphviz', 'lcab', 'libapache2-mod-fcgid',
       'libapache2-mod-proxy-html', 'libapr1', 'libaprutil1',
       'libaprutil1-dbd-sqlite3', 'libaprutil1-ldap',
       'libarchive13', 'libart-2.0-2', 'libavahi-client3',
       'libavahi-common-data',
       'libavahi-common3', 'libcairo2', 'libcdt5', 'libcgraph6',
        'libcups2', 'libcurl3', 'libdatrie1', 'libdbi1',
        'libevent-1.4-2', 'libfile-copy-recursive-perl',
        'libfontconfig1', 'libgd3', 'libgraphite2-3', 'libgsf-1-114',
        'libgsf-1-common', 'libgvc6', 'libgvpr2', 'libharfbuzz0b', 'libice6',
        'libjbig0', 'libjpeg-turbo8', 'libjpeg8', 'liblcms2-2', 'libldb1', 'libltdl7',
        'liblzo2-2', 'libmcrypt4', 'libnet-snmp-perl', 'libnettle4', 'libnspr4',
        'libnss3', 'libnss3-nssdb', 'libpango-1.0-0', 'libpango1.0-0',
        'libpangocairo-1.0-0', 'libpangoft2-1.0-0',
        'libpangox-1.0-0', 'libpangoxft-1.0-0', 'libpathplan4',
        'libperl5.18', 'libpixman-1-0', 'libpoppler44', 'libpython2.7',
        'libradiusclient-ng2', 'librpm3', 'librpmbuild3', 'librpmio3',
        'librpmsign1', 'libsensors4', 'libsm6', 'libsmbclient', 'libsnmp-base',
        'libsnmp-perl', 'libsnmp30', 'libtalloc2', 'libtdb1', 'libtevent0',
        'libthai-data', 'libthai0', 'libtiff5', 'libvpx1', 'libwbclient0',
        'libwebp5', 'libwebpmux1', 'libxaw7', 'libxcb-render0', 'libxcb-shm0',
        'libxft2', 'libxmu6', 'libxpm4', 'libxrender1', 'libxt6', 'php-pear',
        'php5-cgi', 'php5-cli', 'php5-common', 'php5-gd', 'php5-json', 'php5-mcrypt',
        'php5-readline', 'php5-sqlite', 'poppler-utils', 'pyro', 'python-crypto',
        'python-imaging', 'python-ldap', 'python-ldb', 'python-netsnmp', 'python-openssl',
        'python-pil', 'python-renderpm', 'python-reportlab', 'python-reportlab-accel',
        'python-samba', 'python-support', 'python-talloc', 'python-tdb', 'rpm', 'rpm-common',
        'rpm2cpio', 'samba-common', 'samba-common-bin', 'samba-libs', 'smbclient',
        'snmp','ssl-cert', 'traceroute', 'unzip', 'update-inetd', 'x11-common']


  package { $my_deps: ensure => installed }
  #
  # package { 'gdebi-core': ensure => installed }
  #
  #
  file { '/tmp/check-mk-raw-1.2.8p1_0.trusty_amd64.deb':
    ensure => present,
    mode   => '640',
    source =>  "puppet:///modules/checkmk_host/check-mk-raw-1.2.8p1_0.trusty_amd64.deb",
    }

  package { 'check-mk-raw-1.2.8p1':
    provider => 'dpkg',
    ensure   => present,
    source   =>  "/tmp/check-mk-raw-1.2.8p1_0.trusty_amd64.deb",
    }

  exec {'omd create john':
    path   => "/usr/bin:/usr/sbin:/bin",
    onlyif => 'test `omd sites --bare | grep john | wc -l` -eq 0',
    }

  exec {'omd restart john':
    path    => "/usr/bin:/usr/sbin:/bin",
    # onlyif  => "test `omd status --bare john | awk '/OVERALL/ {print $2}'` -eq 1",
    }
}
