$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'dowl'
require 'test/unit'

class OntologyTest < Test::Unit::TestCase
  
  def setup
    file = "examples/example.ttl"
    @schema = DOWL::Schema.create_from_file(File.expand_path(file))         
  end
  
  def test_get_title
    assert_equal( "An Example", @schema.ontology.title )
  end
  
  def test_get_comment
    assert_equal( "This is a simple example", @schema.ontology.comment )
  end

  def test_get_created
    assert_equal( "2010-02-19", @schema.ontology.created )
  end
  
  def test_get_created
    assert_equal( "2010-09-28", @schema.ontology.modified )
  end

  def test_get_authors
    assert_equal( 2 , @schema.ontology.authors.length )
    author = @schema.ontology.authors[0]
    assert_equal( "http://www.ldodds.com#me", author.uri )
    assert_equal( "Leigh Dodds", author.name )
    
    author = @schema.ontology.authors[1]
    assert_equal( "http://www.example.org/unknown", author.uri )
    assert_equal( "http://www.example.org/unknown", author.name )
    
  end
  
        
end