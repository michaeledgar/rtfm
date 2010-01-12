module RTFM
  class AuthorsSection < Section
    def initialize
      super
      @authors = []
      yield self if block_given?
    end
    
    ##
    # Adds an author to the authors section - just a name and e-mail address.
    #
    # Authors will be listed in the order in which they are added using
    # this method.
    #
    # @param [String] name the name of the author
    # @param [String] email (nil) The e-mail address of the author. Need not be
    #   well-formed.
    def add_author(name, email = nil)
      @authors << {:name => name, :email => email}
    end
    alias_method :author, :add_author
    alias_method :add, :add_author
    
    ##
    # Converts the section to groff macros for inclusion in a manfile.
    # This will produce a section entitled "AUTHORS", and a sequential
    # list of authors following it.
    #
    # @return [String] the authors section represented by groff macros.
    def to_groff
      GroffString.groffify do |out|
        out.section "authors"
        @authors.each do |author|
          args = ["\"#{author[:name]}\""]
          if author[:email] then args << "Aq" << author[:email] end
          out.An *args
        end
      end
    end
  end
end
        