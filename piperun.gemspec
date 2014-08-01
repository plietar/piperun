# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'piperun/version'

Gem::Specification.new do |spec|
  spec.name          = "piperun"
  spec.version       = Piperun::VERSION
  spec.authors       = ["Paul Liétar"]
  spec.email         = ["paul@lietar.net"]
  spec.description   = %q{Process files with pipelines}
  spec.summary       = %q{Piperun}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "listen", "~> 2.0"
  spec.add_runtime_dependency "methadone", "~> 1.5"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
end
