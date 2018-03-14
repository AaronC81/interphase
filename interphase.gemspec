# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'interphase'
  s.version       = '1.0.0'
  s.date          = '2018-03-04'
  s.summary       = 'A powerful, easy-to-use, native-looking GUI library'
  s.authors       = ['Aaron Christiansen']
  s.email         = 'aaronc20000@gmail.com'
  s.files         = Dir.glob('lib/**/*')
  s.license       = 'MIT'
  s.require_paths = %w[lib]

  s.add_runtime_dependency 'gtk2', '~> 3.2', '>= 3.2.0'

  s.add_development_dependency 'rake', '~> 12.0', '>= 12.0.0'
  s.add_development_dependency 'rspec', '~> 3.7', '>= 3.7.0'
  s.add_development_dependency 'simplecov', '~> 0.15', '>= 0.15.1'
end
