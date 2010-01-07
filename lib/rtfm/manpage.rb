module RTFM
  class ManPage < Struct.new(:name, :section, :date, :summary)
    
    attr_accessor :name
    attr_accessor :section
    attr_accessor :date
    attr_accessor :summary
    
    
    def initialize(name, section=nil)
      self.name, self.section = name, section
      self.date = DateTime.now
      yield self
    end
    
    def to_groff
      out = GroffString.new
      out.Dd date.strftime("%B %m, %Y")
      out.Os
      out.Dt name, (section || "")
      out.section "NAME"
      out.Nm name
      out.Nd summary
      out.section "SYNOPSIS"
      out.section "DESCRIPTION"
      out.to_s
    end
  end
end