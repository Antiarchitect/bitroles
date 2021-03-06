# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bitroles/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrey Voronkov"]
  gem.email         = ["voronkovaa@gmail.com"]
  gem.description   = %q{Simple roles for your models without external tables}
  gem.summary       = "Bitroles gem v#{Bitroles::VERSION}"
  gem.homepage      = "http://github.com/Antiarchitect/bitroles"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bitroles"
  gem.require_paths = ["lib"]
  gem.version       = Bitroles::VERSION
  gem.add_dependency("activerecord", ">= 3.0.0")
end
