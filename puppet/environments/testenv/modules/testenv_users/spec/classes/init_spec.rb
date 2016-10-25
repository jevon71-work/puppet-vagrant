require 'spec_helper'
describe 'testenv_users' do
  context 'with default values for all parameters' do
    it { should contain_class('testenv_users') }
  end
end
