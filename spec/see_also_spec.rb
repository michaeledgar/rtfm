require 'spec_helper'

describe "see also section" do
  before do
    @see_also = SeeAlsoSection.new do |also|
                  also.reference "madeup", 4
                  also.reference "rails", 1
                  also.reference "ruby"
                  also.reference "perl", 1
                end
  end
  
  it "has a see also section" do
    @see_also.to_groff.should.match(/^.Sh SEE ALSO/)
  end
  
  it "includes references in its see also section" do
    groffed = @see_also.to_groff
    groffed.should.match(/^.Xr rails 1$/)
    groffed.should.match(/^.Xr ruby$/)
    groffed.should.match(/^.Xr perl 1$/)
    groffed.should.match(/^.Xr madeup 4$/)
  end
  
  it "sorts by section" do
    groffed = @see_also.to_groff
    groffed.index(/^.Xr ruby$/).should.be < groffed.index(/^.Xr rails 1$/)
    groffed.index(/^.Xr rails 1$/).should.be < groffed.index(/^.Xr madeup 4$/)
  end
  
  it "sorts within sections" do
    groffed = @see_also.to_groff
    groffed.index(/^.Xr perl 1$/).should.be < groffed.index(/^.Xr rails 1$/)
  end
end