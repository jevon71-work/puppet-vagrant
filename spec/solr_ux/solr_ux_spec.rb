require 'spec_helper'

describe "tests for solr version x" do
  describe file('/usr/java') do
    it { should be_directory }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe service('tomcat6') do
    it { should be_running }
    it { should be_enabled }
  end

  describe file('/etc/default/tomcat6') do
    its(:content) { should match /TOMCAT6_USER=tomcat6/ }
    its(:content) { should match /TOMCAT6_GROUP=tomcat6/ }
    its(:content) { should match /JAVA_HOME=\/usr\/lib\/jvm\/openjdk-6-jdk/ }
    its(:content) { should match /JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX\:\+UseConcMarkSweepGC"/ }
    its(:content) { should match /JAVA_OPTS="\${JAVA_OPTS} -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"/ }
    its(:content) { should match /JSP_COMPILER=javac/ }
    its(:content) { should match /TOMCAT6_SECURITY=no/ }
    its(:content) { should match /-Djava.awt.headless=true -Xmx128m -XX:\+UseConcMarkSweepGC/ }
    its(:content) { should match /LOGFILE_DAYS=14/ }
    its(:content) { should match /JVM_TMP=\/tmp\/tomcat6-temp/ }
    its(:content) { should match /AUTHBIND=no/ }
    its(:content) { should match /unset LC_ALL/ }
  end

 end
