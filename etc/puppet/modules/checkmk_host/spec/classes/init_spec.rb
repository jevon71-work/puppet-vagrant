require 'spec_helper'
describe 'checkmk_host' do

  context 'with default values for all parameters' do
    it { should contain_class('checkmk_host') }
  end
end
