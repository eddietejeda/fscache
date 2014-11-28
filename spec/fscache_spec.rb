# require 'spec_helper'
require_relative '../lib/fscache/fscache'

describe FsCache do

  before do
    @fscache = FsCache.new
    @cache_name = ['spec', 'test']
    @cached_contents = 'Hello World'
    @file_cache_dir = @fscache.instance_variable_get(:@file_cache_dir)
    
  end

  describe "test methods" do

    it "FsCache#initilize should create a tmp directory" do      
      expect(File.directory?(@file_cache_dir)).to be_truthy
    end

    it "FsCache#write should save serialized object to tmp" do
      @fscache.write(@cache_name, @cached_contents)
      expect(@fscache.exist?(@cache_name)).to be_truthy
    end


    it "FsCache#read should be able to read serialized objects" do
      @fscache.read(@cache_name).eql?( @cached_contents)
    end
    

    it "FsCache#fetch should be able to read serialized objects" do
      
      cache_name_fetch = "#{@cache_name}-fetch"
      cache_contents_fetch = "Hello World Fetch"

      response = @fscache.fetch( cache_name_fetch) do
        cache_contents_fetch
      end
      
      cache_name_fetch.eql?( response)
      @fscache.read(cache_name_fetch).eql?( response)
      
    end


    it "FsCache#clear should clear cache" do
      @fscache.clear
      expect(@fscache.exist?(@cache_name)).to be_falsey      
    end

    # it "FsCache#clear should clear cache" do
    #
    #   expect(@fscache.VERSION).to be_truthy
    # end

 

  end
end