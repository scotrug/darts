# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'darts/version'

Gem::Specification.new do |s|
  s.name        = "darts"
  s.version     = Darts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Wynne"]
  s.email       = ["matt@mattwynne.net"]
  s.homepage    = "http://github.com/scotrug/darts"
  s.summary     = "Dependency-aware Ruby testing"
  s.description = "Darts watches your tests run, and builds a map from test case to source code. Now, when you chance your source code, you can ask Darts which tests to run."

  s.required_rubygems_version = ">= 1.3.6"
  ['rspec', 'cucumber'].each do |gem|
    s.add_development_dependency gem
  end

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.executables  = ['darts']
  s.require_path = 'lib'
end
