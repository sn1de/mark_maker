# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mark_maker/version'

Gem::Specification.new do |spec|
  spec.name          = "mark_maker"
  spec.version       = MarkMaker::VERSION
  spec.authors       = ["Brad Schneider"]
  spec.email         = ["brad.schneider@me.com"]
  spec.summary       = %q{Markdown generator.}
  spec.description   = %q{Programatically generate markdown documents.}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "unindent"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "minitest-reporters", '~> 1.1', '>= 1.1.8'
end
