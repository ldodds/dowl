require 'dowl'

module DOWL
  
  class Person < DOWL::DocObject
     def initialize(resource, schema)
       super(resource, schema)
     end
     
     def uri()
       return @resource.uri
     end
     
     def name()
       return get_literal(DOWL::Namespaces::FOAF_NAME)
     end
     
     def <=>(other)
       return name() <=> other.name()
     end
     
  end
  
  class Ontology < DOWL::DocObject
   
    def initialize(resource, schema)
        super(resource, schema)  
    end
    
    def uri() 
        return @resource.uri.to_s
    end
    
    def title()
      return get_literal(DOWL::Namespaces::DCTERMS_TITLE)
    end
    
    def comment()
      return get_literal(DOWL::Namespaces::RDFS_COMMENT)
    end
        
    def created()
      return get_literal(DOWL::Namespaces::DCTERMS_CREATED)
    end

    def modified()
      return get_literal(DOWL::Namespaces::DCTERMS_MODIFIED)
    end
    
    def authors()      
      people = @resource.get_properties(DOWL::Namespaces::FOAF_MAKER)
      authors = []
      if people
        people.each do |s|          
          authors << Person.new(s, @schema)
        end
      end
      return authors.sort     
    end
    
  end
end