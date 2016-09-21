require 'spec_helper'

describe "tests for docker's network" do
	describe command('docker network ls') do
		its(:stdout) { should match /bridge/ }
		its(:stdout) { should match /host/ }
		its(:stdout) { should match /testBridge/ }
		its(:stdout) { should match /solrBridge/ }
		its(:stdout) { should match /none/ }
	end
end
