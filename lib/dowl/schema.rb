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
    
    def Schema.create_from_file(file=nil)
      if file == nil
        raise "Filename should be provided"
      end
      model = RDF::Graph.new(file)
      model.load!
      
      dir = File.dirname(file)
      introduction = File.join(dir, "introduction.html")
      if File.exists?(introduction)
        return Schema.new(model, introduction)
      end      
      return Schema.new(model)
    end       
    
    def init()
      @classes = Hash.new
      init_classes( DOWL::Namespaces::OWL.Class )
      init_classes( DOWL::Namespaces::RDFS.Class )
      ontology = @model.first_subject(RDF::Query::Pattern.new( RDF.type, DOWL::Namespaces::OWL.Ontology ) )
      if ontology
        @ontology = Ontology.new(ontology, self)
      end
      @datatype_properties = init_properties( DOWL::Namespaces::OWL.DatatypeProperty)      
      @object_properties = init_properties( DOWL::Namespaces::OWL.ObjectProperty)
    end
    
    def ontology()
      return @ontology  
    end
    
    def init_classes(type)
      @model.query( RDF::Query::Pattern.new( nil, RDF.type, type ) ) do |statement|
        if !statement.subject.anonymous?
            cls = DOWL::Class.new(statement.subject, self)
            @classes[ statement.subject.to_s ] = cls                    
        end
      end      
    end
    
    def init_properties(type)
      properties = Hash.new
      @model.query( RDF::Query::Pattern.new( nil, RDF.type, type ) ) do |statement|
        properties[ statement.subject.to_s] = DOWL::Property.new(statement.subject, self)
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