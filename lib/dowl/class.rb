module DOWL
  
  class Class < DOWL::LabelledDocObject
    include Comparable
    
    attr_reader :resource
    
    def initialize(resource, schema)
      super(resource, schema)
    end
    
    def uri
      return @resource.uri.to_s
    end
    
    def sub_class_of()
      parent = @resource.get_property(DOWL::Namespaces::RDFS_SUB_CLASS_OF)
      if parent
        uri = parent.uri.to_s
        if @schema.classes[uri]
          return @schema.classes[uri]
        else
          return uri
        end
      end
      return nil
    end
   
    def see_alsos()
       seeAlsos = @resource.get_properties(DOWL::Namespaces::RDFS_SEE_ALSO)
       links = []
       seeAlsos.each do |obj|
         links << obj.uri
       end
       return links
    end
    
    def to_s
      return short_name
    end
    
    def sub_classes()
      children = @resource.model.find(nil, DOWL::Namespaces::RDFS_SUB_CLASS_OF, @resource)
      list = []
      children.each do |child|
        list << DOWL::Class.new(child.subject, @schema)
      end
      return list
    end
    
  end
  
end