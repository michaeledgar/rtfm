module RTFM
  class DescriptionSection < Section
    attr_accessor :options
    
    def initialize
      super
      @options ||= []
      yield self if block_given?
    end
    
    def body=(text)
      self.paragraphs.clear
      self.paragraph text
    end
    
    def add_option(*args)
      if args.size == 1 && args.first.is_a?(Option)
      then @options << args.first
      else @options << Option.new(*args)
      end
    end
    alias_method :option, :add_option
    
    def to_groff
      GroffString.groffify do |out|
        out.section "description"
        paragraphs.each do |par|
          out.paragraph par
        end
        if options.any?
          max_table_width = [14, options.map{|a|a.title.size}.max].min
          out.Bl "-tag", "-width", "#{max_table_width}n", "-compact"
          options.each do |option|
            out << option.to_groff(:item)
          end
          out.El
          out.Pp
        end
      end
    end
  end
end