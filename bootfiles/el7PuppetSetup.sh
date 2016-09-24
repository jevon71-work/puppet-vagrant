# Hardlock domain name
# Can't use this for my setup
# echo 'supercede domain-name "example.com";' > /etc/dhcp/dhclient.conf

# Install etc/hosts for convenience
# Already solved through John's code (hostmanager)
# cp /vagrant/etc-puppet/hosts /etc/hosts

# Add /opt/puppetlabs to the sudo secure_path
sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers

# Install puppet.conf in user directory to share code directory
# mkdir -p /home/vagrant/.puppetlabs/etc/puppet
# cp /vagrant/etc-puppet/personal-puppet.conf /home/vagrant/.puppetlabs/etc/puppet/puppet.conf
# chown -R vagrant:vagrant /home/vagrant/.puppetlabs

# Install example hiera settings in global directory
mkdir -p /etc/puppetlabs/puppet
cp /vagrant/etc-puppet/puppet.conf /etc/puppetlabs/puppet/
mkdir -p /etc/puppetlabs/code
# chown -R vagrant:vagrant /etc/puppetlabs

# Provide the URL to the Puppet Labs yum repo on login
# echo "
# You should start by enabling the Puppet Labs Puppet Collection 1 release repo
#  sudo yum install http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
#
# Then install Puppet 4 and its companion packages
#  sudo yum install -y puppet-agent
#
# " > /etc/motd
# Enable MotD
sed -i -e 's/^PrintMotd no/PrintMotd yes/' /etc/ssh/sshd_config
systemctl reload sshd
yum install -y -q http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y -q puppet-agent
