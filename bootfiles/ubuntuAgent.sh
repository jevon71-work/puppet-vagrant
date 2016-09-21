#!/bin/bash
# source: https://goo.gl/hlh4cw

sudo apt-get clean
sudo apt-get autoclean
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update -y
apt-get install puppet -y git screen

puppet resource package puppet ensure=latest

cp -v /vagrant/etc/puppet/puppet_agent.conf /etc/puppet/puppet.conf

cat<<EOX>/root/kickpuppet.sh
puppet agent --test --no-daemonize --waitforcert 60 --server puppet.vm.vagrant
EOX
