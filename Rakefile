require 'rake'
require 'rdoc/task'
require 'rake/testtask'
require 'rake/clean'

CLEAN.include ['*.gem', 'pkg']  

$spec = eval(File.read('dowl.gemspec'))

Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_dir = 'doc/rdoc'
    rdoc.options += RDOC_OPTS
    rdoc.rdoc_files.include("README", "CHANGES", "lib/**/*.rb")
    rdoc.main = "README"    
end

Rake::TestTask.new do |test|
  test.test_files = FileList['tests/tc_*.rb']
end

task :package do
  sh %{gem build dowl.gemspec}  
end


desc "Install from a locally built copy of the gem"
task :install do
  sh %{rake package}
  sh %{sudo gem install --no-ri --no-rdoc dowl-#{$spec.version}.gem}
end

desc "Uninstall the gem"
task :uninstall => [:clean] do
  sh %{sudo gem uninstall dowl}
end
