describe 'spec_helper'

describe "tests for docker-compose" do
  describe command('docker-compose') do
    its(:exit_status) { should eq 0 }
  end

  describe command('docker-compose run') do
    its(:stdout) { should eq 0}
  end

  describe command('docker-compose build') do
    its(:stdout) { should eq 0}
  end

  describe file('/path/to/docker-compose.yml') do
    it { should exist }
    it { should be file }
    it { should have_mode 0775 }
    it { should be_owned_by 'root'}
    it { should be_grouped_into 'root' }

    its(:content) { should match /ENV PYTHONUNBUFFERED 1/}
    its(:content) { should match /build: __FAIL__/}
    its(:content) { should match /run: __changeme__/}
    its(:content) { should match /command: __changeme_now__/}
    its(:content) { should match /environment: __changeme_again__/}
    its(:content) { should match /expose: __changeme_please__/}
    its(:content) { should match /image: __changeme_one__/}
    its(:content) { should match /__changeme_two__/}
    its(:content) { should match /__changeme_three__/}
    its(:content) { should match /__changeme_four__/}
  end
end
