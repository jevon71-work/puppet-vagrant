require 'spec_helper'

describe "tests for a mongodb server installation" do
  describe package('mongodb') do
    it { should be_installed }
  end

  describe service('mongodb') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('mongo --version') do
    its(:stdout) { should match \/MongoDB shell version: 2.6.11/ }
  end

  describe command('mongod --sysinfo') do
    its(:stdout) { should match \/page size: 4096/ }
    its(:stdout) { should match \/_SC_PHYS_PAGES: 1945630/}
  end
end
