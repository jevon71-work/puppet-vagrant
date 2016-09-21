require 'spec_helper'

describe package('docker') do
	it { should be_installed }
end
