# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zip_recruiter/version'

Gem::Specification.new do |gem|
  gem.name          = "zip_recruiter"
  gem.version       = ZipRecruiter::VERSION
  gem.authors       = ["Adam Dunson"]
  gem.email         = ["adam@cloudspace.com"]
  gem.description   = %q{Provides a CLI and ruby interface to the ZipRecruiter Job Alerts API.}
  gem.summary       = %q{Ruby ZipRecruiter Job Alerts API interface}
  gem.homepage      = "https://github.com/adamdunson/zip_recruiter/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor"
  gem.add_development_dependency "rspec"
end
