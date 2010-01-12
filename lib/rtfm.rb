$:.unshift File.expand_path(File.dirname(__FILE__))

if RUBY_VERSION < "1.9"
  class String
    unless method_defined?(:ord)
      def ord
        self[0]
      end
    end
  end
end

require 'rtfm/groffstring'
require 'rtfm/paragraph'
require 'rtfm/option'
require 'rtfm/section'
require 'rtfm/string_extensions'

Dir[File.expand_path(File.join(File.dirname(__FILE__), "rtfm", "sections", "**"))].each do |f|
  require f
end

require 'rtfm/manpage'