require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rtfm"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
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

task :output do
  require 'lib/rtfm.rb'
  
  out = RTFM::ManPage.new("testing", 2) do |page|
    page.summary = "testing man page"
    page.synopsis do |syn|
      syn.option(:verbose, "")
      syn.option(:silliness, "", :argument => "n")
      syn.option(:input, "", :argument => "<input>")
    end
    page.description do |desc|
      desc.body = "This is a small, temporary description of the testing " +
                  "man page."
      desc.option(:verbose, "The verbose flag does a lot of stuff.")
      desc.option(:silliness, "Set how silly the application should be.", :argument => "n")
      desc.option(:input, "The input flag takes a filename", :argument => "<input>")
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
  
  File.open("testing.2","w") {|o| o << out.to_groff}
end
