module DOWL
  
  class DocObject
    attr_reader :resource
    attr_reader :schema  
    def initialize(resource, schema)
      @resource = resource
      @schema = schema
    end  
    
    def get_literal(property)
      return @schema.model.first_value(RDF::Query::Pattern.new( @resource, property ) )
    end
    
  end
  
  class LabelledDocObject < DOWL::DocObject
    
    def initialize(resource, schema)
       super(resource, schema)
    end
     
    def short_name()
      uri = @resource.to_s
      ontology_uri = @schema.ontology.uri
      if ontology_uri.end_with?("#") || ontology_uri.end_with?("/")
        ontology_uri = ontology_uri[0..-2]
      end
      name = uri.gsub(/#{ontology_uri}(\/|#)?/, "")
      return name
    end
     
    def label()
      return get_literal(DOWL::Namespaces::RDFS.label)
    end
        
    def comment()
      return get_literal(DOWL::Namespaces::RDFS.comment)
    end
    
    def status()      
      return get_literal(DOWL::Namespaces::VS.status)
    end
         
    def <=>(other)
      return label().downcase <=> other.label().downcase
    end    
    
  end
  
end