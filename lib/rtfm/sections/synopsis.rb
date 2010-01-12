module RTFM
  class SynopsisSection < Section
    def initialize
      @options = []
      @arguments = []
      yield self if block_given?
    end
    
    def add_argument(*args)
      @arguments.concat args
    end
    alias_method :add_arguments, :add_argument
    alias_method :argument, :add_argument
    alias_method :arguments, :add_argument
    
    def add_option(*args)
      if args.size == 1 && args.first.is_a?(Option)
      then @options << args.first
      else @options << Option.new(*args)
      end
    end
    alias_method :option, :add_option
    
    def compare_flags(a, b)
      a_ord, b_ord = a.ord, b.ord
      if ('0'.ord .. '9'.ord).include?(a_ord)
        a_ord += 'z'.ord
      end
      if ('0'.ord .. '9'.ord).include?(b_ord)
        b_ord += 'z'.ord
      end
      a_ord <=> b_ord
    end
    
    def to_groff
      flags = @options.select {|opt| opt.title.size == 1 && !opt.argument}
      long_args = @options - flags
      
      GroffString.groffify do |out|
        out.section "synopsis"
        out.put_name
        out.Op "Fl", flags.map {|flag| flag.title}.sort {|a, b| compare_flags(a,b)}.join
        long_args.each do |opt|
          out << opt.to_groff(:option)
        end
        @arguments.each do |arg|
          out.Ar arg
        end
      end
    end
  end
end