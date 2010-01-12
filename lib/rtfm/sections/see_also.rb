module RTFM
  class SeeAlsoSection < Section
    def initialize
      super
      @references = {}
      yield self if block_given?
    end
    def reference(title, section = 0)
      (@references[section] ||= []) << title
    end
    def to_groff
      GroffString.groffify do |out|
        out.section "SEE ALSO"
        @references.keys.sort.each do |section|
          @references[section].sort.each do |title|
            if section == 0
            then out.reference title
            else out.reference title, section
            end
          end
        end
      end
    end
  end
end