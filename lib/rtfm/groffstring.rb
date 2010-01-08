module RTFM
  class GroffString
    
    attr_reader :source
    
    def initialize(str = "")
      @source = str.dup
    end
    
    def to_s
      source
    end
    
    def rstrip
      source.rstrip
    end
    
    def add_line(line)
      source << line.rstrip << "\n"
    end
    alias_method :<<, :add_line
    
    def section(section)
      add_line ".Sh #{section}"
    end
    
    def reference(page, section = nil)
      add_line ".Xr #{page} #{section || ""}"
    end
    
    def method_missing(meth, *args, &block)
      add_line ".#{meth} #{args.join(" ")}"
    end
  end
end