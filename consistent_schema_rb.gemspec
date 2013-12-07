# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'consistent_schema_rb/version'

Gem::Specification.new do |spec|
  spec.name          = "consistent_schema_rb"
  spec.version       = ConsistentSchemaRb::VERSION
  spec.authors       = ["Alex Aitken"]
  spec.email         = ["alex@alexaitken.com"]
  spec.description   = "Orders columns from the active record adapters so the schema dumper will produce a consistent schema.rb"
  spec.summary       = "Orders columns from the active record adapters so the schema dumper will produce a consistent schema.rb"
  spec.homepage      = "http://github.com/alexaitken/consisten_schema_rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "rspec"
end
