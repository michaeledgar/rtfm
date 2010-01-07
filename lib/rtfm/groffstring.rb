module RTFM
  class GroffString
    
    def initialize(str = "")
      @source = str.dup
    end
    
    def to_s
      @source
    end
    
    def section(section)
      ".Sh #{section}"
    end
    
    def method_missing(meth, *args, &block)
      @source << ".#{meth}"
      args.each do |arg|
        @source << " #{arg}"
      end
      @source << "\n"
    end
  end
end