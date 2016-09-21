require 'spec_helper'

describe 'tests for common packages ' do
  common_packages = [ 'puppet', 'puppetlabs-release', 'lsof']

  describe "packages common to all boxes:" do
    common_packages.each do|j|
      describe package(j) do
        it { should be_installed }
      end
    end
  end
end
