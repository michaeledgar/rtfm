$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rtfm/groffstring'
require 'rtfm/option'

Dir[File.expand_path(File.join(File.dirname(__FILE__), "rtfm", "sections", "**"))].each do |f|
  require f
end

require 'rtfm/manpage'