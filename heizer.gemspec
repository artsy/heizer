# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heizer/version'

Gem::Specification.new do |spec|
  spec.name          = 'heizer'
  spec.version       = Heizer::VERSION
  spec.authors       = ['Dylan Fareed']
  spec.email         = %w(email@dylanfareed.com)
  spec.summary       = 'Simple exports to S3 for Gris API apps.'
  spec.description   = 'Simple exports to S3 for Gris API apps.'
  spec.homepage      = 'https://github.com/dylanfareed/heizer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'fog-aws'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'activerecord'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'sequel'
end
