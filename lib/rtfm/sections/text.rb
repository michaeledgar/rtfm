module RTFM
  class TextSection < Section
    attr_accessor :title
    
    def initialize(title, body)
      super
      self.title, self.body = title, body
    end
    
    def body=(par)
      paragraphs.clear
      paragraph par
    end
    
    def to_groff
      GroffString.groffify do |out|
        out.section self.title.to_s.upcase
        paragraphs.each do |par|
          out << par
        end
      end
    end
  end
end