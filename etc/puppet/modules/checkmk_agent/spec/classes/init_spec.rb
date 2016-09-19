require 'spec_helper'
describe 'checkmk_agent' do

  context 'with default values for all parameters' do
    it { should contain_class('checkmk_agent') }
  end
end
