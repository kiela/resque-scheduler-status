$:.unshift File.expand_path('../lib', __FILE__)
require 'resque/plugins/scheduler_status'

Gem::Specification.new do |spec|
  spec.name         = 'resque-scheduler-status'
  spec.version      = Resque::Plugins::SchedulerStatus::VERSION
  spec.authors      = ['Kamil Kieliszczyk']
  spec.email        = ['kamil@kieliszczyk.net']
  spec.description  = ''
  spec.summary      = spec.description
  spec.homepage     = 'https://github.com/kiela/resque-scheduler-status'

  spec.platform = Gem::Platform::RUBY
  spec.required_rubygems_version = '>= 1.3.6'

  spec.files          = `git ls-files`.split($/)
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
end
