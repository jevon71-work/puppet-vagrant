#!/bin/bash
#
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
sudo dpkg -i puppetlabs-release-pc1-trusty.deb
sudo apt-get update --assume-yes
sudo apt-get install puppet-agent screen vim --assume-yes
sudo cp -v /vagrant/etc/puppet/puppet_agent.conf /etc/puppet/puppet.conf
