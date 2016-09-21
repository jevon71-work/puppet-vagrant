#!/bin/bash

yum clean all && yum update -y

# frpm wants ruby, solr wants packaging with fpm!
yum -y install ruby ruby-devel rubygems
gem install fpm --remote

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

yum clean all && yum update -y && yum install screen -y git
yum install puppet-server -y

puppet resource package puppet-server ensure=latest
systemctl enable puppetmaster
systemctl enable puppet

systemctl start puppetmaster
systemctl start puppet

echo "*" > /etc/puppet/autosign.conf
firewall-cmd --add-port=8140/tcp --permanent
firewall-cmd --reload
