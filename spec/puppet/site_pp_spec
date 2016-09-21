require 'spec_helper'

describe "tests for puppet's site.pp file" do
	describe file('/etc/puppet/site.pp') do

  # checking the include statements
    its(:content) { should match /include efcosupdate1/ }
    its(:content) { should match /include efcdockerengine/ }
    its(:content) { should match /include efcdockerrun/ }
    its(:content) { should match /include efcjenkins/ }
    its(:content) { should match /include efcAppd/ }
    its(:content) { should match /include efcsplunk/ }
  end
end
