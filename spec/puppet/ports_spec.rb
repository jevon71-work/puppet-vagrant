require 'spec_helper'
# 61613 - mcollective
# 8140  - puppet agents and certs
# 443   - PE console
# 8142  - puppet orchestration
# 8081  - puppetDB

puppet_ports = [8140]

describe "ports for puppet:" do
  puppet_ports.each do|i|
    describe port(i) do
      it { should be_listening }
    end
  end
end
