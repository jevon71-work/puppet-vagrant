require 'spec_helper'

describe "tests for installed puppet modules" do
  describe command('puppet module list') do
    its(:stdout) { should match /efc-solr/ }
    its(:stdout) { should match /john-module/ }
    its(:stdout) { should match /please-fail/ }
    its(:stdout) { should match /docker_restart/ }
    its(:stdout) { should match /efcappd/ }
    its(:stdout) { should match /efcjenkins/ }
    its(:stdout) { should match /efcosupdate1/ }
    its(:stdout) { should match /efcsplunk/ }
    its(:stdout) { should match /puppet_agent/ }

  end
end
