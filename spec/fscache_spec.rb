# require 'spec_helper'
require_relative '../lib/fscache/fscache'

describe FSCache do

  before do
    @FSCache = FSCache.new
    @cache_name = ['spec', 'test']
    @cached_contents = 'Hello World'
    @file_cache_dir = @FSCache.instance_variable_get(:@file_cache_dir)
    
  end

  describe "test methods" do

    it "FSCache#initilize should create a tmp directory" do      
      expect(File.directory?(@file_cache_dir)).to be_truthy
    end

    it "FSCache#write should save serialized object to tmp" do
      @FSCache.write(@cache_name, @cached_contents)
      expect(@FSCache.exist?(@cache_name)).to be_truthy
    end


    it "FSCache#read should be able to read serialized objects" do
      @FSCache.read(@cache_name).eql?( @cached_contents)
    end
    

    it "FSCache#fetch should be able to read serialized objects" do
      
      cache_name_fetch = "#{@cache_name}-fetch"
      cache_contents_fetch = "Hello World Fetch"

      response = @FSCache.fetch( cache_name_fetch) do
        cache_contents_fetch
      end
      
      cache_name_fetch.eql?( response)
      @FSCache.read(cache_name_fetch).eql?( response)
      
    end


    it "FSCache#clear should clear cache" do
      @FSCache.clear
      expect(@FSCache.exist?(@cache_name)).to be_falsey      
    end

    # it "FSCache#clear should clear cache" do
    #
    #   expect(@FSCache.VERSION).to be_truthy
    # end

 

  end
end