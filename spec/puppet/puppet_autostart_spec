require 'spec_helper'

describe "tests for puppet auto start", :if => os[:osfamily] == 'debian' do
  describe file('/etc/default/puppet') do
    it { should be_file }
    it { shoud exist }
    its(:content) { should match /START=yes/ }
  end
end
