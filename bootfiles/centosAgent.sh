#!/bin/bash
# source: https://goo.gl/MCZtUH


yum remove -y -q epel-release
yum clean all && yum update -y

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

yum clean all && yum update -y

yum install -y puppet screen git
puppet resource package puppet ensure=latest


systemctl enable puppet
systemctl start puppet

# cp -v /vagrant/etc/puppet/puppet_agent.conf /etc/puppet/puppet.conf

cat<<EOX>/root/kickpuppet.sh
puppet agent --test --no-daemonize --waitforcert 60 --server puppet.vm.vagrant
EOX
