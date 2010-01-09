module RTFM
  class AuthorsSection
    def initialize
      @authors = []
      yield self if block_given?
    end
    def add_author(name, email = nil)
      @authors << {:name => name, :email => email}
    end
    alias_method :author, :add_author
    
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
        