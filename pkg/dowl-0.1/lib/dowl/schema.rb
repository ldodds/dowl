module DOWL
  
  #Utility class providing access to information about the schema, e.g. its description, lists of classes, etc
  class Schema
    
    attr_reader :model
    attr_reader :introduction
    attr_reader :datatype_properties
    attr_reader :object_properties
    attr_reader :classes
    
    def initialize(model, introduction=nil)
        @model = model
        @introduction = introduction
        init()
    end
    
    def Schema.create_from_file(file=nil, format="turtle", mimetype="", base=nil)
      if file == nil
        raise "Filename should be provided"
      end
      model = Redland::Model.new()
      parser = Redland::Parser.new(format, mimetype, base)
      parser.parse_into_model(model,"file:#{file}")
      
      dir = File.dirname(file)
      introduction = File.join(dir, "introduction.html")
      if File.exists?(introduction)
        return Schema.new(model, introduction)
      end      
      return Schema.new(model)
    end       
    
    def init()
      @classes = Hash.new
      init_classes( DOWL::Namespaces::OWL_CLASS )
      init_classes( DOWL::Namespaces::RDFS_CLASS )
      ontology = model.subject(Redland::TYPE, DOWL::Namespaces::OWL_ONTOLOGY)
      if ontology
        @ontology = Ontology.new(ontology, self)
      end
      @datatype_properties = init_properties( DOWL::Namespaces::OWL_DATATYPE_PROPERTY)      
      @object_properties = init_properties( DOWL::Namespaces::OWL_OBJECT_PROPERTY)
    end
    
    def ontology()
      return @ontology  
    end
    
    def init_classes(type)
      model.find(nil, Redland::TYPE, type) do |s,p,o|
        if s.resource?
            cls = DOWL::Class.new(s, self)
            @classes[ s.uri.to_s ] = cls                    
        end
      end      
    end
    
    def init_properties(type)
      properties = Hash.new
      model.find(nil, Redland::TYPE, type) do |s,p,o|
        properties[ s.uri.to_s] = DOWL::Property.new(s, self)
      end      
      return properties      
    end
    
    def properties()
      return @datatype_properties.merge( @object_properties )     
    end
    
    def list_properties()
      return properties().sort { |x,y| x[1] <=> y[1] }          
    end
    
    def list_datatype_properties()
      return datatype_properties().sort { |x,y| x[1] <=> y[1] }
    end
    
    def list_object_properties()
      return object_properties().sort { |x,y| x[1] <=> y[1] }
    end    
    
    #Return sorted, nested array
    def list_classes()
      sorted = classes().sort { |x,y| x[1] <=> y[1] }
      return sorted      
    end
    
  end  
  
end