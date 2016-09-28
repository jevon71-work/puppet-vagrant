# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end

  # everything is centos7.
  config.vm.box = "centos7"
  # unless i say so

  config.vm.define "jcwlinux01", primary: true do |jcwlinux01|
    jcwlinux01.vm.hostname = "jcwlinux01.vm.local"
    # prov
    jcwlinux01.vm.provision "shell", path: "./bootfiles/epel.sh"
    jcwlinux01.vm.provision "shell", path: "./bootfiles/el7PuppetSetup.sh"

    jcwlinux01.vm.network "private_network", ip: "192.168.40.201"

  end

  config.vm.define "jcwlinux02", primary: true do |jcwlinux02|
    jcwlinux02.vm.box = "ubuntu-14-04-LTS-x64"
    jcwlinux02.vm.hostname = "jcwlinux02.vm.local"
    # prov
    jcwlinux02.vm.provision "shell", path: "./bootfiles/ubuntuTidy.sh"

    jcwlinux02.vm.network "private_network", ip: "192.168.40.211"

  end

  config.vm.define "jcwlinux03", primary: true do |jcwlinux03|
    jcwlinux03.vm.box = "ubuntu-16.04-amd64"
    jcwlinux03.vm.hostname = "jcwlinux03.vm.local"
    # prov
    jcwlinux03.vm.provision "shell", path: "./bootfiles/ubuntuTidy.sh"

    jcwlinux03.vm.network "private_network", ip: "192.168.40.221"

  end


# I don't want these VMs (yet) so commenting them out
#   config.vm.define "puppet", primary: true do |puppet|
#     puppet.vm.hostname = "puppet.vm.vagrant"
#     # prov
#     puppet.vm.provision "shell", path: "./bootfiles/centosPM.sh"
#
#     puppet.vm.synced_folder "etc/puppet", "/etc/puppet"
#     puppet.vm.network "private_network", ip: "192.168.33.5"
#
#   end
#
#   # centos7
#   config.vm.define "solr01" do |solr01|
#     solr01.vm.hostname = "solr01.vm.vagrant"
#     solr01.vm.network "private_network", ip: "192.168.33.20"
#     solr01.vm.provision "shell", path: "./bootfiles/centosAgent.sh"
#   end
#
#   config.vm.define "solr02" do |solr02|
#     solr02.vm.hostname = "solr02.vm.vagrant"
#     solr02.vm.network "private_network", ip: "192.168.33.37"
#     solr02.vm.provision "shell", path: "./bootfiles/centosAgent.sh"
#   end
#
#   # ubuntu14
#   config.vm.define "solr03"  do |solr03|
#     solr03.vm.box = "ux14"
#     solr03.vm.hostname = "solr03.vm.vagrant"
#     solr03.vm.network "private_network", ip: "192.168.33.48"
#     solr03.vm.provision "shell", path: "./bootfiles/ubuntuAgent.sh"
#   end
#
#   config.vm.define "solr04" do |solr04|
#     solr04.vm.box = "ux14"
#     solr04.vm.hostname = "solr04.vm.vagrant"
#     solr04.vm.network "private_network", ip: "192.168.33.59"
#     solr04.vm.provision "shell", path: "./bootfiles/ubuntuAgent.sh"
#   end
      # handle hostnames
      config.hostmanager.enabled = true
      config.hostmanager.manage_host = true
      config.hostmanager.manage_guest = true
      config.hostmanager.ignore_private_ip = false
      config.hostmanager.include_offline = true

end

# Below is the code from John Maclean's LAXPT Vagrant Repository.  It is now
# deprecated but the code was good, except for my failing if statement...
# # Require YAML module
# require 'yaml'
#
# # Read YAML file with box details
# servers = YAML.load_file('bootfiles/vagrant.yaml')
#
# # Create boxes
# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#
#   # Iterate through entries in YAML file
#   servers.each do |servers|
#     config.vm.define servers["name"] do |srv|
#       srv.vm.box = servers["box"]
#       srv.vm.network "private_network", ip: servers["ip"]
#       srv.vm.hostname = servers["hostname"]
#
#       # provision all hosts with some tidying up
#       if servers["box"] == '/centos*/'
#         srv.vm.post_up_message = "#{servers["box"]}"
#         srv.vm.provision "shell", path: "bootfiles/epel.sh"
#         srv.vm.provision "shell", path: "bootfiles/el7PuppetSetup.sh"
#       # elsif servers["box"] == '/centos7/'
#       #   srv.vm.provision "shell", path: "bootfiles/epel.sh"
#       elsif servers["box"] == '/ubuntu*/'
#         puts "#{server["box"]}"
#         srv.vm.provision "shell", path: "bootfiles/ubuntuTidy.sh"
#       # else
#       #   srv.vm.provision "shell", path: "bootfiles/epel.sh"
#       #   srv.vm.provision "shell", path: "bootfiles/el7PuppetSetup.sh"
#       end
#       # srv.vm.provision "shell", privileged: false, inline: <<-EOF
#       #   echo "Vagrant Box provisioned!"
#       #   echo "Box type is: #{$servers.box}"
#       #   echo "hostname is: #{$servers.hostname}"
#       # EOF
#
#       # handle hostnames
#       config.hostmanager.enabled = true
#       config.hostmanager.manage_host = true
#       config.hostmanager.manage_guest = true
#       config.hostmanager.ignore_private_ip = false
#       config.hostmanager.include_offline = true
#
#       srv.vm.provider :virtualbox do |vb|
#         vb.name = servers["name"]
#         vb.memory = servers["ram"]
#       end # end of provider
#
#     end
#   end # end of servers.each
#
# end # end of Vagrant

# Below is the code pulled from the author of Learning Puppet 4.  I am
# replacing it with code created by John Maclean
# Copy files into place
$setupscript = <<END
  # Hardlock domain name
  echo 'supercede domain-name "example.com";' > /etc/dhcp/dhclient.conf

  # Install etc/hosts for convenience
  cp /vagrant/etc-puppet/hosts /etc/hosts

  # Add /opt/puppetlabs to the sudo secure_path
  sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers

  # Install puppet.conf in user directory to share code directory
  mkdir -p /home/vagrant/.puppetlabs/etc/puppet
  cp /vagrant/etc-puppet/personal-puppet.conf /home/vagrant/.puppetlabs/etc/puppet/puppet.conf
  chown -R vagrant:vagrant /home/vagrant/.puppetlabs

  # Install example hiera settings in global directory
  mkdir -p /etc/puppetlabs/puppet
  cp /vagrant/etc-puppet/puppet.conf /etc/puppetlabs/puppet/
  mkdir -p /etc/puppetlabs/code
  chown -R vagrant:vagrant /etc/puppetlabs

  # Provide the URL to the Puppet Labs yum repo on login
  echo "
You should start by enabling the Puppet Labs Puppet Collection 1 release repo
   sudo yum install http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

Then install Puppet 4 and its companion packages
   sudo yum install -y puppet-agent

" > /etc/motd
  # Enable MotD
  sed -i -e 's/^PrintMotd no/PrintMotd yes/' /etc/ssh/sshd_config
  systemctl reload sshd
END

# Keeping old definitions, so I can reference them later
# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#   config.vm.box = "puppetlabs/centos-7.2-64-nocm"
#   config.vm.provider :virtualbox do |vb|
#     vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
#     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
#   end
#
#   # clients
#   config.vm.define "client", primary: true do |client|
#     client.vm.hostname = "client.example.com"
#     client.vm.network :private_network, ip: "192.168.250.10"
#     client.vm.provision "shell", inline: $setupscript
#   end
#
#   config.vm.define "web1", primary: true do |webserver|
#     webserver.vm.hostname = "web1.example.com"
#     webserver.vm.network :private_network, ip: "192.168.250.21"
#     webserver.vm.provision "shell", inline: $setupscript
#   end
#   config.vm.define "web2", primary: true do |webserver|
#     webserver.vm.hostname = "web2.example.com"
#     webserver.vm.network :private_network, ip: "192.168.250.22"
#     webserver.vm.provision "shell", inline: $setupscript
#   end
#   config.vm.define "web3", primary: true do |webserver|
#     webserver.vm.hostname = "web3.example.com"
#     webserver.vm.network :private_network, ip: "192.168.250.23"
#     webserver.vm.provision "shell", inline: $setupscript
#   end
#
#   # A puppetmaster
#   config.vm.define "puppetmaster", autostart: false do |puppetmaster|
#     puppetmaster.vm.hostname = "puppetmaster.example.com"
#     puppetmaster.vm.network :private_network, ip: "192.168.250.5"
#     puppetmaster.vm.provision "shell", inline: $setupscript
#   end
#
#   # Puppet Server
#   config.vm.define "puppetserver", autostart: false do |puppetserver|
#     puppetserver.vm.hostname = "puppetserver.example.com"
#     puppetserver.vm.network :private_network, ip: "192.168.250.6"
#     puppetserver.vm.provision "shell", inline: $setupscript
#     puppetserver.vm.provider :virtualbox do |ps|
#       ps.memory = 1024
#     end
#   end
#
#   # Puppet Dashboard
#   config.vm.define "dashboard", autostart: false do |puppetserver|
#     puppetserver.vm.hostname = "dashserver.example.com"
#     puppetserver.vm.network :private_network, ip: "192.168.250.7"
#     puppetserver.vm.provision "shell", inline: $setupscript
#     puppetserver.vm.provider :virtualbox do |ps|
#       ps.memory = 1024
#     end
#   end
# end
