require 'rubygems'
require 'erb'
require 'rdf'
require 'fileutils'
require 'linkeddata'
require 'dowl/util'
require 'dowl/schema'
require 'dowl/class'
require 'dowl/property'
require 'dowl/ontology'
require 'dowl/generator'

module DOWL
      
  class Namespaces

    OWL = RDF::Vocabulary.new("http://www.w3.org/2002/07/owl#")    
    RDFS = RDF::RDFS    
    VS = RDF::Vocabulary.new("http://www.w3.org/2003/06/sw-vocab-status/ns#")    
    DCTERMS = RDF::Vocabulary.new("http://purl.org/dc/terms/")
    FOAF = RDF::Vocabulary.new("http://xmlns.com/foaf/0.1/")
        
  end

end
