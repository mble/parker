require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'
require 'reek/rake/task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns =
    %w( Rakefile Gemfile parker.gemspec lib/**/*.rb spec/*_spec.rb )
  t.fail_on_error = true
end

Reek::Rake::Task.new do |t|
  t.name = :reek
  t.fail_on_error = false
end

task default: [:rubocop, :spec, :reek]
