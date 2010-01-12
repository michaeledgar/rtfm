module RTFM
  
  class Section
    
    attr_accessor :paragraphs
    
    def initialize(*args)
      @paragraphs ||= []
    end
    
    def paragraph(text)
      @paragraphs << Paragraph.new(text)
    end
  end
end