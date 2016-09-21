require 'spec_helper'

describe 'tests for the OS ' do
  # ux only
  describe file('/etc/lsb-release'), :if => os[:family] == 'ubuntu' do
    it { should be_file }
    its(:content) { should match /^DISTRIB_ID=Ubuntu$/ }
    its(:content) { should match /^DISTRIB_RELEASE=14.04$/ }
    its(:content) { should match /DISTRIB_CODENAME=trusty/ }
    its(:content) { should match /DISTRIB_DESCRIPTION="Ubuntu 14.04.4 LTS"/ }
  end

  # cx only
  describe file('/etc/os-release'), :if => os[:family] == 'redhat' do
    it { should be_file }
    its(:content) { should match /^NAME="CentOS Linux"$/ }
    its(:content) { should match /^VERSION="7 \(Core\)"/ }
    its(:content) { should match /^ID="centos"/ }
    its(:content) { should match /^ID_LIKE="rhel fedora"/ }
    its(:content) { should match /^PRETTY_NAME="CentOS Linux 7 \(Core\)"/ }
    its(:content) { should match /^REDHAT_SUPPORT_PRODUCT_VERSION="7"/ }
  end
end
