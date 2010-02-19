require 'rubygems'
require 'erb'
require 'rdf/redland'

require 'dowl/util'
require 'dowl/schema'
require 'dowl/class'
require 'dowl/property'
require 'dowl/ontology'
require 'dowl/generator'

module DOWL
      
  class Namespaces

    OWLNS = Redland::Namespace.new("http://www.w3.org/2002/07/owl#")
    
    OWL_CLASS = OWLNS["Class"]
    OWL_ONTOLOGY = OWLNS["Ontology"]
    OWL_DATATYPE_PROPERTY = OWLNS["DatatypeProperty"]
    OWL_OBJECT_PROPERTY = OWLNS["ObjectProperty"]
    
    RDFS = Redland::Namespace.new("http://www.w3.org/2000/01/rdf-schema#")
    
    RDFS_CLASS = RDFS["Class"]
    RDFS_LABEL = RDFS["label"]
    RDFS_COMMENT = RDFS["comment"]
    RDFS_SUB_CLASS_OF = RDFS["subClassOf"]
    RDFS_SUB_PROPERTY_OF = RDFS["subPropertyOf"]
    RDFS_SEE_ALSO = RDFS["seeAlso"]
    RDFS_RANGE = RDFS["range"]
    RDFS_DOMAIN = RDFS["domain"]
    
    VS = Redland::Namespace.new("http://www.w3.org/2003/06/sw-vocab-status/ns#")
    
    VS_STATUS = VS["term_status"]
    
    DCTERMS = Redland::Namespace.new("http://purl.org/dc/terms/")
    DCTERMS_TITLE = DCTERMS["title"]
    DCTERMS_CREATED = DCTERMS["created"]
    DCTERMS_MODIFIED = DCTERMS["modified"]
    
    FOAF = Redland::Namespace.new("http://xmlns.com/foaf/0.1/")
    
    FOAF_MAKER = FOAF["maker"]
    FOAF_NAME = FOAF["name"]
        
  end

end
