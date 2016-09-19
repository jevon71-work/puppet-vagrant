#!/bin/bash
#
# this node should already have the epel repo
yum remove -y -q epel-release
yum clean all
yum update -y
yum install -y -q epel-release screen bash-completion

yum install -y puppet
cp -v /vagrant/etc/puppet/puppet_agent.conf /etc/puppet/puppet.conf

cat<<EOX>/root/kickpuppet.sh
puppet agent --test --no-daemonize --waitforcert 60
EOX
