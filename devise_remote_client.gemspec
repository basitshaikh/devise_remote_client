# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_remote_client/version'

Gem::Specification.new do |spec|
  spec.name          = "devise_remote_client"
  spec.version       = DeviseRemoteClient::VERSION
  spec.authors       = ["Valentin Ballestrino"]
  spec.email         = ["vala@glyph.fr"]
  spec.summary       = %q{Models and strategies to use devise in a client Rails app}
  spec.description   = %q{Models and strategies to use devise in a client Rails app}
  spec.homepage      = "https://github.com/glyph-fr/devise_remote_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "devise", "~> 5.0"
  spec.add_dependency "rails", "~> 5.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 3.3.2"
  spec.add_development_dependency "factory_girl_rails", '~> 4.5.0'
  spec.add_development_dependency 'tzinfo-data', '~> 1.2015.5'
  spec.add_development_dependency "capybara", "~> 2.4.4"
end
