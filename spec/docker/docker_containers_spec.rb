require 'spec_helper'

containers = ['container_one', 'container_two', 'container_three']

describe "tests for docker containers" do
	containers.each do |i|
		describe docker_container(i) do
      it { should exist }
			it { should be_running }
			it { should have_volume '/var/lib/testing_something/fail'}
		end
	end
end
