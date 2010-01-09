module RTFM
  class DescriptionSection < Struct.new(:body, :options)
    def initialize(*args)
      super
      self.options ||= []
      yield self if block_given?
    end
    
    def add_option(*args)
      if args.size == 1 && args.first.is_a?(Option)
      then self.options << args.first
      else self.options << Option.new(*args)
      end
    end
    alias_method :option, :add_option
    
    def to_groff
      GroffString.groffify do |out|
        out.section "description"
        out << self.body
        if options.any?
          out.Bl "-tag", "-width", "\"mmmmmmmmmm\"", "-compact"
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