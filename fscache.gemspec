#encoding: utf-8
require File.expand_path('../lib/fscache.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'fscache'
  gem.version     = FsCache::VERSION
  gem.description = %q(A simple file cache library that serializes objects into temporary directory)
  gem.summary     = gem.description
  
  gem.files       = `git ls-files`.split("\n")
  gem.require_paths = ['lib']  
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.homepage    = "https://github.com/eddietejeda/fscache"

  gem.license     = 'BSD-3-Clause'
  gem.authors     = ['Eddie A Tejeda']
  gem.email       = ['eddie@codeforamerica.org']

  gem.add_development_dependency 'rake','~> 10.x'
  gem.add_development_dependency 'rspec','~> 3.x'

end

