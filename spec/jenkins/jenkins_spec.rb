require 'spec_helper'

describe yumrepo('jenkins') do
  it { should exist }
end

describe package('java-1.7.0-openjdk') do
  it { should be_installed}
end

describe package('jenkins') do
  it { should be_installed }
end

describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end

describe service('FirewallD') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end
