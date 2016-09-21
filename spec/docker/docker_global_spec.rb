require 'spec_helper'

describe "tests for docker global status" do
  describe command('docker info')	do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Containers: 4/ }
    its(:stdout) { should match /Storage Driver: devicemapper/ }
    its(:stdout) { should match /Data Space Total: 107.4 GB/ }
    its(:stdout) { should match /Metadata Space Total: 2.147 GB/ }
    its(:stdout) { should match /Data loop file: \/var\/lib\/docker\/devicemapper\/devicemapper\/data/ }
    its(:stdout) { should match /Library Version: 1.02.107-RHEL7 (2015-12-01)/ }
    its(:stdout) { should match /Execution Driver: native-0.2/ }
    its(:stdout) { should match /Logging Driver: json-file/ }
    its(:stdout) { should match /CPUs: 4/ }
    its(:stdout) { should match /Total Memory: 7.422 GiB/ }
  end
end
