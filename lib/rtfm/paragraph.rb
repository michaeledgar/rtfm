module RTFM
  ##
  # A class for representing a paragraph in a groff document. We wrap
  # our strings in these so that we can perform groff transformations,
  # such as converting bold text, that have semantics defined in a
  # paragraph. Plain text should still be inserted using string objects.
  class Paragraph
    attr_accessor :text
    def initialize(text)
      self.text = text
    end
    
    ONE_ASTERISK_REGEX = /\s+\*(.*?)\*\s*/
    TWO_ASTERISK_REGEX = /\s+\*\*(.*?)\*\*\s*/
    ONE_UNDERSCORE_REGEX = /\s+\_(.*?)\_\s*/
    TWO_UNDERSCORE_REGEX = /\s+\_\_(.*?)\_\_\s*/
    
    def text_groffed
      text.gsub(TWO_ASTERISK_REGEX, "\n.Em \\1\n").gsub(ONE_ASTERISK_REGEX, "\n.Sy \\1\n").
           gsub(TWO_UNDERSCORE_REGEX, "\n.Em \\1\n").gsub(ONE_UNDERSCORE_REGEX, "\n.Sy \\1\n").
           gsub(/\n\.(\s|$)/, "\n\\\\&.\\1")
    end
    
    def to_groff
      GroffString.groffify do |out|
        out.Pp
        out << text_groffed
      end
    end
  end
end