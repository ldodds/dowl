require 'dowl'

module DOWL
  
  class Property < DOWL::LabelledDocObject
    
    def initialize(resource, schema)
      super(resource, schema)
    end
    
    def see_alsos()
       links = []
       @schema.model.query(
         RDF::Query::Pattern.new( @resource, DOWL::Namespaces::RDFS.seeAlso ) ) do |statement|
         links << statement.object.to_s
       end       
       return links
    end
        
    def sub_property_of()
      parent = @schema.model.first_value(
        RDF::Query::Pattern.new( @resource, DOWL::Namespaces::RDFS.subPropertyOf) )
      if parent
        uri = parent.to_s
        if @schema.properties[uri]
          return @schema.properties[uri]
        else
          return uri
        end
      end
      return nil
    end
        
    def range()
      ranges = []
      @schema.model.query(RDF::Query::Pattern.new( @resource, DOWL::Namespaces::RDFS.range ) ) do |statement|
        ranges << statement.object
      end  
      classes = []
      ranges.each do |o|
        if o.resource?
          uri = o.to_s        
          if @schema.classes[uri]
            classes << @schema.classes[uri]
          else
            classes << uri
          end
        end
      end
      return classes
    end

    def domain()
      domains = []
      @schema.model.query(RDF::Query::Pattern.new( @resource, DOWL::Namespaces::RDFS.domain ) ) do |statement|
        domains << statement.object
      end  
      classes = []
      domains.each do |o|
        if o.resource?
          uri = o.to_s         
          if @schema.classes[uri]
            classes << @schema.classes[uri]
          else
            classes << uri
          end
        end
        #TODO union
      end
      return classes
    end
    
    def sub_properties()
      list = []
      @schema.model.query(RDF::Query::Pattern.new( nil, DOWL::Namespaces::RDFS.subPropertyOf, @resource ) ) do |statement|
        list << DOWL::Property.new( statement.subject, @schema )
      end
      return list
    end            
  end
end