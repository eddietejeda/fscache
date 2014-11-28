#FsCache
Simple FileCache with that uses similar API to Rails.cache

#Installation
    gem install fscache

Or add the following to your Gemfile (do this for now):
    
    gem 'fscache', :git => 'git://github.com/eddietejeda/fscache.git'

#Usage examples

    require 'fscache'
    filecache = FsCache.new
    filecache.write("cache_name", "cache_contents")
    contents = filecache.read("cache_name")
    filecache.fetch("cache_name") do
        "cache_contents"
    end