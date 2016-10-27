require 'spec_helper'
describe 'setup_workstation' do
  context 'with default values for all parameters' do
    it { should contain_class('setup_workstation') }
  end
end
