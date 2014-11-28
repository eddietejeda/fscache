#encoding: utf-8
require File.expand_path('../lib/fscache/fscache', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'fscache'
  gem.version     = FSCache::VERSION
  gem.description = %q(A simple file cache library that serializes objects in tmp directory)
  gem.summary     = gem.description
  
  gem.files       = `git ls-files`.split("\n")
  gem.require_paths = ['lib']  
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")


  gem.authors     = ['Eddie A Tejeda']
  gem.email       = ['eddie@codeforamerica.org']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

end

