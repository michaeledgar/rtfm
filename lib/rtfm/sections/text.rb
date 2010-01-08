module RTFM
  class TextSection < Struct.new(:title, :body)
    def to_groff
      GroffString.groffify do |out|
        out.section title.to_s.upcase
        out << body.to_s
      end
    end
  end
end