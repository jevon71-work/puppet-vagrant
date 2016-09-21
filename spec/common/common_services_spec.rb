require 'spec_helper'

describe "common services for all boxes" do
  centos_service_list = ['crond', 'puppet', 'sshd']

  centos_service_list.each do |x|
    describe service(x), :if => os[:family] == 'redhat' do
      it { should be_enabled }
    end
  end

  ubuntu_service_list = ['cron', 'puppet', 'ssh']

  ubuntu_service_list.each do |y|
    describe service(y), :if => os[:family] == 'ubuntu' do
      it { should be_enabled }
    end
  end


end
