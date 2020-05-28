# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'jekyll_recker/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-recker'
  spec.version       = Jekyll::Recker::VERSION
  spec.authors       = ['Alex Recker']
  spec.email         = ['alex@reckerfamily.com']
  spec.summary       = 'The Greatest Jekyll Plugin in the World'
  spec.homepage      = 'https://www.github.com/arecker/jekyll-recker/'
  spec.license       = 'GPLv3'
  spec.files         = [
    'LICENSE',
    'README.md',
    Dir['_includes/**/*.html'],
    Dir['_layouts/**/*.html'],
    Dir['assets/*.scss'],
    Dir['assets/*.css'],
    Dir['lib/**/*.rb']
  ].flatten

  spec.add_development_dependency 'bump'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'

  spec.add_runtime_dependency 'jekyll', '~> 3.8'
  spec.add_runtime_dependency 'koala'
  spec.add_runtime_dependency 'slack-notifier'
  spec.add_runtime_dependency 'twitter'
end
