module RTFM
  class Option < Struct.new(:title, :desc, :opts)
    def to_groff
      GroffString.groffify do |out|
        out.Pp
        
        args = []
        args << :Fl
        args << self.title
        
        if opts[:argument] || opts[:arg]
          argument = (opts[:argument] || opts[:arg])
          if argument[0,1] == "<" && argument[-2,1] == ">"
            args << "Ao"
            args << argument[1..-2]
            args << "Ac"
          else
            args << :Ar
            args << argument
          end
        end
        out.It *args
        out << self.desc
      end
    end
  end
  
  class DescriptionSection < Struct.new(:body, :options)
    def initialize(*args)
      super
      self.options ||= []
      yield self if block_given?
    end
    
    def add_option(title, desc, opts = {})
      self.options << Option.new(title, desc, opts)
    end
    
    def to_groff
      GroffString.groffify do |out|
        out.section "description"
        out << self.body
        if options.any?
          out.Bl "-tag", "-width", "\"mmmmmmmmmm\"", "-compact"
          options.each do |option|
            out << option.to_groff
          end
          out.El
          out.Pp
        end
      end
    end
  end
end