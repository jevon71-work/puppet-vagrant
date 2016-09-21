# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end

  # everything is centos7.
  config.vm.box = "cx7"
  # unless i say so

  config.vm.define "puppet", primary: true do |puppet|
    puppet.vm.hostname = "puppet.vm.vagrant"
    # prov
    puppet.vm.provision "shell", path: "./bootfiles/centosPM.sh"

    puppet.vm.synced_folder "etc/puppet", "/etc/puppet"
    puppet.vm.network "private_network", ip: "192.168.33.5"

  end

  # centos7
  config.vm.define "solr01" do |solr01|
    solr01.vm.hostname = "solr01.vm.vagrant"
    solr01.vm.network "private_network", ip: "192.168.33.20"
    solr01.vm.provision "shell", path: "./bootfiles/centosAgent.sh"
  end

  config.vm.define "solr02" do |solr02|
    solr02.vm.hostname = "solr02.vm.vagrant"
    solr02.vm.network "private_network", ip: "192.168.33.37"
    solr02.vm.provision "shell", path: "./bootfiles/centosAgent.sh"
  end

  # ubuntu14
  config.vm.define "solr03"  do |solr03|
    solr03.vm.box = "ux14"
    solr03.vm.hostname = "solr03.vm.vagrant"
    solr03.vm.network "private_network", ip: "192.168.33.48"
    solr03.vm.provision "shell", path: "./bootfiles/ubuntuAgent.sh"
  end

  config.vm.define "solr04" do |solr04|
    solr04.vm.box = "ux14"
    solr04.vm.hostname = "solr04.vm.vagrant"
    solr04.vm.network "private_network", ip: "192.168.33.59"
    solr04.vm.provision "shell", path: "./bootfiles/ubuntuAgent.sh"
  end
end
