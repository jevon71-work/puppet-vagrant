require 'spec_helper'

describe "tests for puppet fileserver.conf" do
  describe file('/etc/puppet/fileserver.conf') do
    it { should be_file }
    it { should be_mode 644 }
  end
end
