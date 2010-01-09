require 'rake'
require 'rtfm'

namespace :man do
  desc "Display your man files in man."
  task :debug do
    require 'tempfile'
    require 'rtfm'
    RTFM::ManPage.all_pages.each do |page|
      Tempfile.open("#{page.name}.#{page.section}") do |f|
        f << page.to_groff
        f.flush
        system("man #{f.path}")
      end
    end
  end
  
  desc "Generate your manual files in the man/ directory"
  task :gen do
    FileUtils.makedirs "man/"
    RTFM::ManPage.all_pages.each do |page|
      File.open("man/#{page.name}.#{page.section}", "w") do |f|
        f << page.to_groff
      end
    end
  end
  
  desc "Install your manual files globally"
  task :install => :gen do
    if Rake.application.unix?
      Dir["man/*"].each do |manfile|
        section = manfile.split(".").last
        begin
          FileUtils.cp(manfile, "/usr/share/man/man#{section}/")
        rescue Errno::EACCES
          puts "I'm sorry, but you need root privileges to install man pages with this version"+
               " of RTFM."
        end
      end
    else
      raise "Can't install man pages without a unix-based OS."
    end
  end
end