# puppet-vagrant

## Objective(s)

- [x] A vagrant set up for puppet.

- [x] Use this lab to test anything pupppet-related.

- [x] Use serverspec to test the vagrant boxes (prove my puppet-foo).


## Assumptions

- [x] virtualbox

- [x] vagrant

- [x] ruby, rubygems, puppet


## Tools needed

The state of my workstation at time of writing:-

````bash
vagrant --version
Vagrant 1.8.1

### For automajic handling of hostnames
vagrant plugin install vagrant-hostmanager

ruby --version
ruby 2.0.0p648 (2015-12-16 revision 53162) [universal.x86_64-darwin15]
````



### Ruby gems - install me!!
````bash
gem list | awk '/puppet |bundler|rake/'
bundler (1.11.2)
puppet (4.5.0 universal-darwin, 4.4.2 universal-darwin)
rake (11.1.2, 10.5.0, 0.9.6)
rspec-puppet (2.4.0, 2.0.1)
````

### Vagrant boxes

````bash
vagrant status
Current machine states:

puppet
solr01
solr02
zk01
zk02
````

## Usage summary

### On host
* $editor Vagrantfile - define your server "specs". RAM, IP, vagrant box etc

* `vagrant up` to bring up all boxes

* `vagrant hostmanager` # automajic for /etc/hosts

* `vagrant ssh puppet` # log into this box. do your puppet foo

### inside puppetmaster

* `sudo sh /vagrant/bootfiles/centosPM.sh` # install puppetmaster and *screen*

* run `screen`

* start puppet master with `puppet master --no-daemonize`

* All hosts are *autosigned*. No need to sign certs.


### inside puppet agent

* `vagrant ssh [node]` # log into "agent". puppet agent foo here

install puppet agent

* `sudo sh /vagrant/bootfiles/centosPA.sh`

Agent wil be autosigned. So from now run;

* `puppet agent --test`

## Serverspec testing

Bring all of the boxes up. Use `bundle install` to install serverspec. Vagrant boxes are now ready for testing.

Refer to the available list of tests below. These tests are role-based, in the fact that I don't care where my boxes are, but what they __do__. Also refer to the tree below to add new roles for server testing.

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
head properties.yml                                                                                         ~/projects/LAXPT
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

Once you have added a new dir under spec and added some tests, they will be listed here.


````bash
 rake spec -T
rake spec            # Run testing to all hosts
rake testing:puppet  # Run testing to puppet.vm.local
rake testing:solr01  # Run testing to solr01.vm.local
rake testing:solr02  # Run testing to solr02.vm.local
rake testing:zoo01   # Run testing to zoo01.vm.local
rake testing:zoo02   # Run testing to zoo02.vm.local
rake testing:zoo03   # Run testing to zoo03.vm.local                  # Run serverspec to all hosts
````

## sources

I nicked code from these sources

* https://goo.gl/MDNxR8

* http://goo.gl/Y18HDe

* all over the place ;-)
