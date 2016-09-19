# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "300"
  end

  config.vm.box = "cx7"

  # all boxes get these
  config.vm.provision "shell", path: "./bootfiles/centosAgent.sh"

  config.vm.define "puppet", primary: true do |puppet|
    puppet.vm.hostname = "puppet.vm.vagrant"
    # prov
    puppet.vm.provision "shell", path: "./bootfiles/centosPM.sh"

    puppet.vm.synced_folder "etc/puppet", "/etc/puppet"
    puppet.vm.network "private_network", ip: "192.168.33.5"

  end

  config.vm.define "solr01" do |solr01|
    solr01.vm.hostname = "solr01.vm.vagrant"
    solr01.vm.network "private_network", ip: "192.168.33.20"
  end

  config.vm.define "solr02" do |solr02|
    solr02.vm.hostname = "solr02.vm.vagrant"
    solr02.vm.network "private_network", ip: "192.168.33.37"
  end

  config.vm.define "zk01"  do |zk01|
    zk01.vm.hostname = "zk01.vm.vagrant"
    zk01.vm.network "private_network", ip: "192.168.33.48"
  end

  config.vm.define "zk02" do |zk02|
    zk02.vm.hostname = "zk02.vm.vagrant"
    zk02.vm.network "private_network", ip: "192.168.33.59"
  end
end
