require 'spec_helper'


describe 'Testing Linux kernel version: ' do
  describe command('uname -a'), :if => os[:family] == 'redhat' do
    its(:stdout) { should match /3.10/ }
  end

  describe command('uname -a'), :if => os[:family] == 'ubuntu' do
    its(:stdout) { should match /4.2.0/ }
  end
end
