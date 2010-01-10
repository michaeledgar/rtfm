require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rtfm"
    gem.summary = "Create makefiles declaratively. Comes with rake tasks."
    gem.description = <<-EOF
Using RTFM, you can declaratively create nice, standard man pages for your 
Ruby projects using a slick, maintainable DSL. It also includes rake tasks 
to aid in debugging, generating, and installing your man files.
EOF
    gem.email = "michael.j.edgar@dartmouth.edu"
    gem.homepage = "http://github.com/michaeledgar/rtfm"
    gem.authors = ["Michael Edgar"]
    gem.add_development_dependency "bacon", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "lib"))
require 'rtfm'
require 'rtfm/tasks'

RTFM::ManPage.new("testing", 2) do |page|
  page.summary = "testing man page"
  page.option :r, "Some r flag"
  page.option :j, "Some j flag"
  page.option :k, "Some k flag"
  page.option :"0", "Some zero flag"
  page.option :A, "Some capitalized flag"
  page.option :Z, "some big-z flag"
  page.option :verbose, "The verbose flag does a lot of stuff."
  page.option :silliness, "Set how silly the application should be.", :argument => "n"
  page.option :input, "The input flag takes a filename", :argument => "<input>"
  
  page.description do |desc|
    desc.body = "This is a small, temporary description of the testing " +
                "man page."
  end
  page.see_also do |also|
    also.reference "rails", 1
    also.reference "ruby"
  end
  page.bugs = "There are a few bugs, but nothing too serious."
  page.history = "This program has a storied history that I am too " +
                 "lazy to include here."
  page.authors do |section|
    section.author "Michael Edgar", "adgar@carboni.ca"
  end
end
