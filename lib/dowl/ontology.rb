require 'dowl'

module DOWL
  
  class Person < DOWL::DocObject
     def initialize(resource, schema)
       super(resource, schema)
     end
     
     def uri()
       return @resource.to_s
     end
     
     def name()
       name = get_literal(DOWL::Namespaces::FOAF.name)
       if name == nil
         name = uri()
       end
       return name
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
        return @resource.to_s
    end
    
    def title()
      return get_literal(DOWL::Namespaces::DCTERMS.title)
    end
    
    def comment()
      return get_literal(DOWL::Namespaces::RDFS.comment)
    end
        
    def created()
      return get_literal(DOWL::Namespaces::DCTERMS.created)
    end

    def modified()
      return get_literal(DOWL::Namespaces::DCTERMS.modified)
    end
    
    def authors()      
      authors = []
      @schema.model.query( 
        RDF::Query::Pattern.new( @resource, DOWL::Namespaces::FOAF.maker ) ) do |statement|
          authors << Person.new( statement.object, @schema )
      end         
      return authors.sort     
    end
    
  end
end