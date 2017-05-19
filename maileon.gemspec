# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maileon/version'

Gem::Specification.new do |spec|
  spec.name          = "maileon"
  spec.version       = Maileon::VERSION
  spec.authors       = ["Ain Tohvri"]
  spec.email         = ["at@interactive-pioneers.de"]
  spec.summary       = %q{Ruby wrapper for Maileon API.}
  spec.description   = %q{Ruby wrapper for Maileon email marketing software API.}
  spec.homepage      = "https://github.com/interactive-pioneers/maileon"
  spec.license       = "GPL-3.0"
  spec.required_ruby_version = ">= 2.0.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "excon", "~> 0.45.4"
  spec.add_runtime_dependency "json", "~> 1.8"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rspec-nc", "~> 0.2"
  spec.add_development_dependency "rspec-its", "~> 1.2"
  spec.add_development_dependency "guard", "~> 2.2"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-remote", "~> 0.1"
  spec.add_development_dependency "pry-nav", "~> 0.2"
  spec.add_development_dependency "webmock", "~> 1.20"
  spec.add_development_dependency "sinatra", "~> 1.4"
  spec.add_development_dependency "coveralls", "~> 0.7.11"
end
