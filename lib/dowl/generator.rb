module DOWL

  class Generator
    
    def initialize(schema, template=Generator.default_template())
      @template = ERB.new(File.read(template))
      @schema = schema
      if schema.introduction
        @introduction = File.read(schema.introduction)
      end      
    end
    
    def Generator.default_template()
       dir = File.dirname( __FILE__ )
       return default_template_file = File.join(dir, "default.erb")
    end
    
    def copy_assets
      asset_dir = File.join( File.dirname( __FILE__ ), "assets" )
      Dir.new(asset_dir).each() do |file|
        if file != "." and file != ".."
          File.copy( File.join(asset_dir, file), Dir.pwd )
        end
      end      
    end
    
    def run()   
      copy_assets()   
      b = binding
      schema = @schema
      introduction = @introduction
      return @template.result(b)               
    end
    
  end  
  
end
