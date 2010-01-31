require 'dowl'

module DOWL
  
  class Property < DOWL::LabelledDocObject
    
    def initialize(resource, schema)
      super(resource, schema)
    end
    
    def see_alsos()
       seeAlsos = @resource.get_properties(DOWL::Namespaces::RDFS_SEE_ALSO)
       links = []
       seeAlsos.each do |obj|
         links << obj.uri
       end
       return links
    end
        
    def sub_property_of()
      parent = @resource.get_property(DOWL::Namespaces::RDFS_SUB_PROPERTY_OF)
      if parent
        uri = parent.uri.to_s
        if @schema.properties[uri]
          return @schema.properties[uri]
        else
          return uri
        end
      end
      return nil
    end
        
    def range()
      ranges = @resource.get_properties(DOWL::Namespaces::RDFS_RANGE)
      classes = []
      if ranges
        ranges.each do |o|
          if o.resource?
            uri = o.uri.to_s        
            if @schema.classes[uri]
              classes << @schema.classes[uri]
            else
              classes << uri
            end
          end
        end
      end
      return classes
    end

    def domain()
      domains = @resource.get_properties(DOWL::Namespaces::RDFS_DOMAIN)
      classes = []
      if domains
        domains.each do |o|
          if o.resource?
            uri = o.uri.to_s         
            if @schema.classes[uri]
              classes << @schema.classes[uri]
            else
              classes << uri
            end
          end
          #TODO union
        end
      end
      return classes
    end
    
    def sub_properties()
      children = @resource.model.find(nil, DOWL::Namespaces::RDFS_SUB_PROPERTY_OF, @resource)
      list = []
      children.each do |child|
        list << DOWL::Property.new(child.subject, @schema)
      end
      return list
    end            
  end
end