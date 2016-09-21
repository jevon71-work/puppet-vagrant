describe 'spec_helper'

describe "tests for puppet auth.conf" do
  describe file('/etc/puppet/auth.conf') do
    it { should be_mode 644 }
    it { should be_owned_by 'vagrant' }
    it { should be_grouped_into 'vagrant' }

    its(:content) { should match /^allow */ }
    its(:content) { should match /^path \/certificate\// }
    its(:content) { should match /^path \/certificate\/ca/ }
    its(:content) { should match /path \/certificate_request/ }
    its(:content) { should match /path \/certificate_revocation_list\/ca/ }
    its(:content) { should match /path \/file/ }
    its(:content) { should match /path \/v2.0\/environments/ }
  end
end
