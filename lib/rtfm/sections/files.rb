module RTFM
  class FilesSection < Section
    def initialize
      super
      @files = []
      yield self if block_given?
    end
    
    ##
    # Adds a file to the files section. "desc" can be formatted like
    # any other paragraph (including with special formatters like *text*)
    #
    # @param [String] name the name of the file
    # @param [String] desc a paragraph describing the file's purpose or
    #   use
    def add_file(name, desc)
      @files << {:name => name, :body => Paragraph.new(desc)}
    end
    alias_method :file, :add_file
    alias_method :add,  :add_file
    
    ##
    # Converts the files section to groff, for inclusion in a manfile.
    #
    # @return [String] the files section turned into groff macros, so
    #  it will be rendered correctly in a manfile.
    def to_groff
      GroffString.groffify do |out|
        max_file_name_size = [18, @files.map {|x| x[:name].size}.max].min
        out.Bl "-tag", "-width", "#{max_file_name_size}n", "-compact"
        @files.sort {|a, b| a[:name] <=> b[:name]}.each do |file|
          out.It file[:name]
          out << file[:body]
        end
        out.El
      end
    end
  end
end