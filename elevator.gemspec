# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elevator/version'

Gem::Specification.new do |spec|
  spec.name          = 'elevator'
  spec.version       = Elevator::VERSION
  spec.authors       = ['Gustavo Bazan']
  spec.email         = ['gssbzn@gmail.com']

  spec.summary       = 'A simple elevator simulation'
  spec.description   = 'Simulate an elevator, construct one with a list of floors and enjoy the travel,'
  spec.homepage      = 'https://github.com/gssbzn/elevator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  spec.add_development_dependency 'coveralls', '~>0.8.0', '>= 0.8.0'
  spec.add_development_dependency 'yard', '~> 0.8.7', '>= 0.8.0'
end
