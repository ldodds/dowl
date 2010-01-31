$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'dowl'
require 'test/unit'

class SchemaTest < Test::Unit::TestCase
  
  OWL_CLASS = "<http://www.example.com/class> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2002/07/owl#Class>. "  
  RDF_CLASS = "<http://www.example.com/class> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2000/01/rdf-schema#Class>. "
  
  def setup()
    
  end
  
  def teardown()
    
  end
  
  def test_cannot_create_from_nil_file
      assert_raise RuntimeError do
        DOWL::Schema.create_from_file(nil) 
      end
  end
  
  def test_create_from_file
    file = "examples/wo.ttl"
    DOWL::Schema.create_from_file(File.expand_path(file))     
  end
  
  def test_read_classes_from_sample()
    file = "examples/wo.ttl"
    schema = DOWL::Schema.create_from_file(File.expand_path(file))     
    classes = schema.classes()
    assert_not_nil classes
    assert_equal(28, classes.length)
  end
  
  def test_identify_owl_classes()
    model = Redland::Model.new()
    parser = Redland::Parser.turtle()
    uri = Redland::Uri.new("http://www.example.com/")
    parser.parse_string_into_model(model, OWL_CLASS, uri)
    schema = DOWL::Schema.new(model)
    assert_equal(1, schema.classes.length)
  end

  def test_identify_rdf_classes()
    model = Redland::Model.new()
    parser = Redland::Parser.turtle()
    uri = Redland::Uri.new("http://www.example.com/")
    parser.parse_string_into_model(model, RDF_CLASS, uri)
    schema = DOWL::Schema.new(model)
    assert_equal(1, schema.classes.length)
  end
end
