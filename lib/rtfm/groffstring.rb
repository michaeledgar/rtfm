module RTFM
  class GroffString
    
    attr_reader :source
    
    def self.groffify(str = "")
      out = self.new(str)
      yield out
      out.to_s
    end
    
    def initialize(str = "")
      @source = str.dup
    end
    
    def to_s
      source
    end
    
    def add_line(line)
      source << line.to_groff.rstrip << "\n"
    end
    alias_method :<<, :add_line
    
    def section(section)
      self.Sh section.upcase
    end
    
    def paragraph(text)
      text = Paragraph.new(text) unless text.is_a?(Paragraph)
      self << text
    end
    
    def put_name
      self.Nm
    end
    
    def reference(page, section = nil)
      self.Xr page, (section || "")
    end
    
    def method_missing(meth, *args, &block)
      add_line ".#{meth} #{args.join(" ")}"
    end
  end
end