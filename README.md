# vagrant-working

## Description

This repository contains a Vagrantfile and some Serverspec to spin up a Linux-
based environment so that I can work.  I will focus on using CentOS as my main
system of choice, but will also have a Ubuntu box or two for testing purposes.
I have started the repository by basing it on the code provided to create the
Learning Puppet 4 book published by O'Reilly.

## Objectives

I plan to provision and configure the systems using Puppet code, so each system
will have everything I need to do my work:

1.  Puppet 4 Agent installed
2.  Terraform version 0.6.x (latest version)
3.  Terraform version 0.7.x (latest "non-buggy" version)
4.  Python 3 / PIP 3 - required for ssaml stuff created by Jeremy Witte
5.  Git, so I can push / pull repos locally from GitHub / BitBucket
6.  Serverspec, so I can test the effects of my code changes
7.  TestKitchen, additional testing platform

I will be expanding my requirements as I go - I would like to have a CI server
as part of this environment, so I don't need to always manually run tests.
Ultimately I would like to share this code base with other Systems Engineers at
DHI Group Inc.

## Assumptions

- [x] virtualbox

- [x] vagrant

- [x] ruby, rubygems, puppet


## Tools needed

The state of my workstation at time of writing:-

I am not really into Macs, so right now this is all on a Windows 7 machine.  I
may switch to a Linux-based workstation in the future...

````bash
vagrant --version
Vagrant 1.7.4

### For automajic handling of hostnames
vagrant plugin install vagrant-hostmanager

vagrant plugin list
vagrant-hostmanager (1.8.1)
vagrant-share (1.1.5, system)
vagrant-vbguest (0.11.0)

ruby --version
ruby 2.2.4p230 (2015-12-16 revision 53155) [x64-mingw32]
````



### Ruby gems - install me!!
````bash
gem list | awk '/puppet |bundler|rake/'
bundler (1.12.5)
puppet-lint (1.1.0)
rake (10.4.2)
````

### Vagrant boxes

````bash
vagrant status
Current machine states:

jcwlinux01
jcwlinux02
````

## Usage summary

### On host
* $editor Vagrantfile - define your server "specs". RAM, IP, vagrant box etc

* `vagrant up` to bring up all boxes

* `vagrant hostmanager` # automajic for /etc/hosts

* `vagrant ssh jcwlinux01` # log into this box. do your puppet foo

## Serverspec testing

Bring all of the boxes up. Use `bundle install` to install serverspec. Vagrant
boxes are now ready for testing.

Refer to the available list of tests below. These tests are role-based, in the
fact that I don't care where my boxes are, but what they __do__. Also refer to
the tree below to add new roles for server testing.

### Role-based testing

Put your __roles__ into a new directory, like spec/blah.

````bash
ls -1 spec
common
puppet
solr
````

Add your servers to the roles as shown below.

````bash
head properties.yml
# role-based puppet => role-based testing!!
puppet01.vm.local:
  :roles:
    - commonss
    - puppet
xmon.vm.local:
  :roles:
    - common
    - role2
    - docker
````    

Once you have added a new dir under spec and added some tests, they will be
listed here.


````bash
 rake spec -T
rake spec            # Run testing to all hosts
rake testing:puppet  # Run testing to puppet.vm.local
rake testing:solr01  # Run testing to solr01.vm.local
rake testing:solr02  # Run testing to solr02.vm.local
rake testing:zoo01   # Run testing to zoo01.vm.local
rake testing:zoo02   # Run testing to zoo02.vm.local
rake testing:zoo03   # Run testing to zoo03.vm.local
                     # Run serverspec to all hosts
````

## sources

This is forked from jayeola/puppet-vagrant, but has code from jayeola/LAXPT and jorhett/learning-puppet4.

I will also steal code from wherever seems appropriate...
