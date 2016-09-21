require 'spec_helper'

# puppet-lint ?? ', 'puppet', 'puppetdb ??']
cx_puppet_packages = [
  'puppet',
  'puppet-server',
  'ruby',
  'ruby-devel',
  'rubygems',
]

ux_puppet_packages = ['puppetmaster', 'puppet']


describe "packages for puppet master:" do
  cx_puppet_packages.each do |v|
    describe package(v), :if => os[:family] == 'redhat' do
      it { should be_installed }
    end
  end

  ux_puppet_packages.each do |p|
    describe package(p), :if => os[:family] == 'ubuntu' do
      it { should be_installed }
    end
  end

  describe command('gem list --local') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /fpm/ }
  end

end
