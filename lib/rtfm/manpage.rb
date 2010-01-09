module RTFM
  class ManPage < Struct.new(:name, :section, :date, :summary, :synopsis, :description, :authors)
    class << self
      def text_section(*args)
        args.each do |sect|
          class_eval %Q{
            def #{sect}
              @#{sect} ||= TextSection.new(:#{sect}, "")
            end
            def #{sect}=(str)
              @#{sect} = TextSection.new(:#{sect}, str)
            end
          }
        end
      end
      alias_method :text_sections, :text_section
      
      def add_section(name, klass)
        klass = klass.to_s.intern
        class_eval %Q{
          def #{name}
            @#{name} ||= #{klass}.new
            yield @#{name} if block_given?
            @#{name}
          end
        }
      end
      
    end
    
    text_section :bugs, :diagnostics, :compatibility, :standards, :history
    add_section :see_also, SeeAlsoSection
    add_section :description, DescriptionSection
    add_section :authors, AuthorsSection
    
    def initialize(name, section=nil)
      self.name, self.section = name, section
      self.date = DateTime.now
      self.synopsis = nil
      yield self
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
        out << synopsis if synopsis
        [@description, @see_also, @history, @authors, @bugs].each do |sect|
          out << sect.to_groff if sect
        end
      end
    end
  end
  
end