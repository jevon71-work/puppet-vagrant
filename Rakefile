require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

properties = YAML.load_file('./bootfiles/properties.yml')

desc "Run spec to all hosts"
task :spec => 'spec:all'

namespace :spec do
  task :all => properties.keys.map {|key| 'spec:' + key.split('.')[0] }
  properties.keys.each do |key|
    desc "Run spec to #{key}"
    RSpec::Core::RakeTask.new(key.split('.')[0].to_sym) do |t|
      ENV['TARGET_HOST'] = key
      t.pattern = 'spec/{' + properties[key][:roles].join(',') + '}/*_spec.rb'
    end
  end
end
