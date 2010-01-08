module RTFM
  class ManPage < Struct.new(:name, :section, :date, :summary)
    
    attr_accessor :name
    attr_accessor :section
    attr_accessor :date
    attr_accessor :summary
    attr_accessor :synopsis
    attr_accessor :description
    
    def initialize(name, section=nil)
      self.name, self.section = name, section
      self.date = DateTime.now
      self.synopsis = ""
      self.description = ""
      yield self
    end
    
    def see_also
      @see_also = GroffString.new
      yield @see_also
      @see_also
    end
    
    [:bugs, :diagnostics, :compatibility, :standards, :history].each do |sect|
      class_eval %Q{
        def #{sect}
          @#{sect} ||= TextSection.new(:#{sect}, "")
        end
        def #{sect}=(str)
          @#{sect} = TextSection.new(:#{sect}, str)
        end
      }
    end
    
    def to_groff
      GroffString.groffify do |out|
        out.Dd date.strftime("%B %d, %Y")
        out.Os
        out.Dt name, (section || "")
        out.section "NAME"
        out.Nm name
        out.Nd summary
        out.section "SYNOPSIS"
        out << synopsis
        out.section "DESCRIPTION"
        out << description
        if @see_also
          out.section "SEE ALSO"
          out << @see_also
        end
        out << @history.to_groff if @history
        out << @bugs.to_groff if @bugs
      end
    end
  end
  
  class TextSection < Struct.new(:title, :body)
    def to_groff
      GroffString.groffify do |out|
        out.section title.to_s.upcase
        out << body.to_s
      end
    end
  end
end