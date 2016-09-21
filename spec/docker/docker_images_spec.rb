require 'spec_helper'

image_list = ['docker.io/mysql',
              'docker.io/jenkins',
              'docker.io/macadmins/puppetmaster']

describe "tests for docker images" do
  describe docker_image('docker.io/mysql:latest') do
    it { should exist}
  end
end
