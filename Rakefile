require 'rspec/core/rake_task'

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

