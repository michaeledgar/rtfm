module RTFM
  class Option < Struct.new(:title, :desc, :opts)
    def title
      super.to_s
    end
        
    def argument
      opts && (opts[:argument] || opts[:arg])
    end
    
    def to_groff(how)
      GroffString.groffify do |out|
        args = [:Fl, self.title]
        
        if self.argument
          argument = self.argument.to_s
          if argument[0,1] == "<" && argument[-1,1] == ">"
            args << "Ao" << argument[1..-2] << "Ac"
          elsif argument[0,1] == "[" && argument[-1,1] == "]"
            args << "Oo" << argument[1..-2] << "Oc"
          else
            args << :Ar << argument
          end
        end
        
        case how
        when :option
          out.Op *args
        when :item
          out.Pp
          out.It *args
          out << self.desc
        end
      end
    end
  end
end