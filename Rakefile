require 'rspec/core/rake_task'
require './sample/sample'

RSpec::Core::RakeTask.new(:spec)

desc "Run sample project"
task :sample do
  Sample.new.run
end

task :default => :spec
