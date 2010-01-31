module DOWL
  
  class DocObject
    attr_reader :resource
    attr_reader :schema  
    def initialize(resource, schema)
      @resource = resource
      @schema = schema
    end  
    
    def get_literal(property)
      object = @resource.get_property(property)
      if object
        return object.value
      end  
      return nil      
    end
    
  end
  
  class LabelledDocObject < DOWL::DocObject
     def initialize(resource, schema)
       super(resource, schema)
     end
     def short_name()
       uri = resource.uri.to_s
       ontology_uri = schema.ontology.uri.to_s
       return uri.gsub(ontology_uri, "")
     end
    def label()
      return get_literal(DOWL::Namespaces::RDFS_LABEL)
    end    
    def comment()
      return get_literal(DOWL::Namespaces::RDFS_COMMENT)
    end
    def status()      
       return get_literal(DOWL::Namespaces::VS_STATUS)
    end     
    def <=>(other)
      return label().downcase <=> other.label().downcase
    end    
  end
  
end