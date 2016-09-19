#!/bin/bash
#
yum install -y puppet\* rubygem-puppet\* screen
echo "*" > /etc/puppet/autosign.conf
firewall-cmd --add-port=8140/tcp --permanent
firewall-cmd --reload