#FileCache
Simple FileCache with that uses similar API to Rails.cache

##Installation

   gem install filecache

Or add the following to your Gemfile (do this for now):

   gem 'filecache', :git => 'git://github.com/eddietejeda/filecache.git'


##Usage examples

   require 'filecache'

   filecache = FileCache.new
   filecache.write("cache_name", "cache_contents")
   contents = filecache.read("cache_name")
   
   filecache.fetch("cache_name") do
     "cache_contents"
   end
