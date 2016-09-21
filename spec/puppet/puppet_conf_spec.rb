require 'spec_helper'

describe "tests for puppet.conf" do
  describe file('/etc/puppet/puppet.conf') do
    it { should be_file }
    it { should exist }
    it { should be_mode 644 }
    it { should be_owned_by 'vagrant' }
    it { should be_grouped_into 'vagrant' }

    # its(:content) { should match /certname=puppetmaster.efinancialcareers.com/}
    # its(:content) { should match /codedir = \/etc\/puppetlabs\/code/}
    # its(:content) { should match /environment_timeout = 60/}
    # its(:content) { should match /environmentpath = $codedir\/environments/ }
    its(:content) { should match /logdir = \/var\/log\/puppet/ }
    # its(:content) { should match /pidfile = \/var\/run\/puppetlabs\/puppetserver\/puppetserver.pid/ }
    # its(:content) { should match /reports = store,puppetdb/ }
    # its(:content) { should match /server=puppetmaster.efinancialcareers.com /}
    # its(:content) { should match /storeconfigs=true/ }
    # its(:content) { should match /storeconfigs_backend=puppetdb/}
    # its(:content) { should match /vardir = \/var\/lib\/puppet/}
    # its(:content) { should match /$factpath=\$vardir\/lib\/facter/ }
    # its(:content) { should match /postrun_command=\/etc\/puppet\/etckeeper-commit-post/ }
    # its(:content) { should match /prerun_command=\/etc\/puppet\/etckeeper-commit-pre/ }
    # its(:content) { should match /rundir=\/var\/run\/puppet/ }
    # its(:content) { should match /ssl_client_header = SSL_CLIENT_S_DN/ }
    # its(:content) { should match /ssl_client_verify_header = SSL_CLIENT_VERIFY/ }
    # its(:content) { should match /ssldir=\/var\/lib\/puppet\/ssl/ }
    # its(:content) { should match /templatedir=\$confdir\/templates/ }
    # its(:content) { should match /var\/log\/puppetlabs\/puppetserver/ }
  end
end
