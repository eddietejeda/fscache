require 'digest'
require 'fileutils'
require 'pathname'
require 'yaml'
  
class FSCache
  VERSION = "0.9.0"
  
  def initialize(path = nil, expire = 7, debug = false)
    @file_cache_expire = expire
    @debug = debug
    default_tmp = defined?(Rails).nil? ? Pathname.new("/tmp").join('file_cache') : Rails.root.join('tmp').join('file_cache')    
    @file_cache_dir = path.nil? ? default_tmp : path     
    FileUtils::mkdir_p @file_cache_dir if !File.directory?(@file_cache_dir)    
  end



  def exist?(cache_name)    
    cache_name = cache_key( cache_name )
    cache_path = @file_cache_dir.join(cache_name)    

    cache_valid(cache_path)
  end


  def read(cache_name)    
    cache_name = cache_key( cache_name )
    cache_path = @file_cache_dir.join(cache_name)

    if @debug
      p exist?(cache_name) ? "#{cache_name}: cache hit" :  "#{cache_name}: cache miss"
    end

    if File.exist?(cache_path)
      YAML.load(File.read(cache_path))
    else
      return false
    end    
  end


  def write(cache_name, cache_value)    
    cache_name = cache_key( cache_name )
    cache_path = @file_cache_dir.join(cache_name)

    File.open(cache_path, 'w') do |f| 
      f.write(YAML.dump(cache_value)) 
    end    
  end


  def fetch(cache_name)    
    cache_name = cache_key( cache_name )

    if(exist? (cache_name) )
      read (cache_name)
    else
      value = yield
      write(cache_name, value)  
      read (cache_name)    
    end    
  end

  def clear    
    Dir["#{@file_cache_dir}/*"].each do |cache_name| 
      # lets make sure we're only deleting files with md5 hashes as filenames.      
      if cache_key( File.basename(cache_name) )
        FileUtils.rm(cache_name)
      end
    end
  end

  # --------- private --------- 
  private
    def cache_valid(filename)      
      if File.exist?(filename) 
        ((Time.now - File.stat(filename).mtime).to_i / 86400.0).to_i < @file_cache_expire
      else
        return false
      end
    end

    def cache_key(key)      
      if(key.is_a?(String) && key.downcase.match(/^[a-f0-9]{32}$/) )
        key
      else
        Digest::MD5.hexdigest(key.to_s).to_s        
      end      
    end
end
