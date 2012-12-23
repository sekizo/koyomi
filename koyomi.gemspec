# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koyomi/version'

Gem::Specification.new do |gem|
  gem.name          = "koyomi"
  gem.version       = Koyomi::VERSION
  gem.authors       = ["sekizo"]
  gem.email         = ["sekizoworld@mac.com"]
  gem.description   = %q{Extends Date class to handling with calendar.}
  gem.summary       = %q{Add some classes to handle year, month, period.}
  gem.homepage      = ""
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  #--------------------#
  # additionals
  gem.add_development_dependency "shoulda"
  
end
