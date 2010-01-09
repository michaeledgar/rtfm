require 'rake'
require 'rtfm'

namespace :man do
  task :debug do
    require 'tempfile'
    require 'rtfm'
    RTFM::ManPage.all_pages.each do |page|
      Tempfile.open("#{page.name}.#{page.section}") do |f|
        f.write page.to_groff
        f.flush
        system("man #{f.path}")
      end
    end
  end
end