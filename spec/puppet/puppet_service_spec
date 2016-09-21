require 'spec_helper'

describe service('puppetmaster') do
  it {should be_running }
  it {should be_enabled }
  # monitored by....
end

describe command('dpkg -l puppetmaster'), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /3.4.3/ }
end

describe command('puppet master --version') do
  its(:stdout) { should match /3.4.3/ }
end

describe command('rpm -qa| grep puppetmaster'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /3.4.3/ }
end
