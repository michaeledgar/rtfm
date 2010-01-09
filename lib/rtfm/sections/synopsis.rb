module RTFM
  class SynopsisSection
    def initialize
      @options = []
      yield self if block_given?
    end
    
    def add_option(title, desc, opts = {})
      @options << Option.new(title, desc, opts)
    end
    alias_method :option, :add_option
    
    def to_groff
      GroffString.groffify do |out|
        out.section "synopsis"
        out.put_name
        @options.each do |opt|
          out << opt.to_groff(:option)
        end
      end
    end
  end
end