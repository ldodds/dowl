VER = "0.7"

RDOC_OPTS = ['--quiet', '--title', 'dowl Reference', '--main', 'README']

PKG_FILES = %w( README Rakefile CHANGES ) + 
  Dir.glob("{bin,doc,tests,examples,lib}/**/*")

Gem::Specification.new do |s|
    s.name = "dowl"
    s.version = VER
    s.platform = Gem::Platform::RUBY
    s.required_ruby_version = ">= 1.9"    
    s.has_rdoc = true
    s.extra_rdoc_files = ["README", "CHANGES"]
    s.rdoc_options = RDOC_OPTS
    s.summary = "dowl OWL/RDF doc generator"
    s.description = "Generate simple HTML documentation for subset of RDFS/OWL"
    s.author = "Leigh Dodds"
    s.email = 'leigh@ldodds.com'
    s.homepage = 'http://github.com/ldodds/dowl'
    s.files = PKG_FILES
    s.require_path = "lib" 
    s.bindir = "bin"
    s.executables = ["dowl"]
    s.test_file = "tests/ts_dowl.rb"
    s.add_dependency("mocha", ">= 0.9.5")
    s.add_dependency("linkeddata", ">=1.0")
    s.add_dependency("redcarpet", ">=2.2.2")
end
