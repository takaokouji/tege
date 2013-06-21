# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tege/version'

Gem::Specification.new do |spec|
  spec.name          = "tege"
  spec.version       = Tege::VERSION
  spec.authors       = ["Kouji Takao"]
  spec.email         = ["kouji.takao@gmail.com"]
  spec.description   = %q{a test code generator for Ruby on Rails and RSpec.}
  spec.summary       = %q{tege is a test code generator for Ruby on Rails and RSpec.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "active_support"
end
