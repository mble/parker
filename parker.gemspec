# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parker/version'

Gem::Specification.new do |s|
  s.name          = 'parker'
  s.summary       = 'HipChat GH Priority Bug Notifier - Not Production Ready'
  s.author        = 'Matt Blewitt'
  s.email         = 'matthew@salesmaster.co.uk'
  s.license       = 'MIT'
  s.version       = Parker::VERSION
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.bindir        = 'bin'
  s.executables   << 'parker'
  s.description   = 'HipChat GH Priority Bug Notifier - Not Production Ready'

  s.test_files    = `git ls-files spec/*`.split
  s.files         = `git ls-files`.split
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.1.0'

  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rake', '~> 10.2'
  s.add_development_dependency 'rubocop', '~> 0.28.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'fuubar', '~> 2.0'
  s.add_development_dependency 'pry', '~> 0.10', '>= 0.10.1'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4', '>= 0.4.0'
  s.add_development_dependency 'yard', '~> 0.8.7'
  s.add_development_dependency 'reek'
  s.add_development_dependency 'vcr', '~> 2.9.2'
  s.add_development_dependency 'webmock', '>= 1.9'
  s.add_runtime_dependency 'octokit', '~> 3.3'
  s.add_runtime_dependency 'rotp', '~> 2.0'
  s.add_runtime_dependency 'hipchat', '~> 1.5.1'
  s.add_runtime_dependency 'dotenv', '~> 2.0.1'
end
