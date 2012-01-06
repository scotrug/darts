require 'bundler'
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'
Cucumber::Rake::Task.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :default => [:spec, :cucumber]
