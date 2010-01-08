require 'spec_helper'

describe "rtfm" do
  before do
    @rtfm = ManPage.new("testing") do |page|
              page.date = Date.parse("1/2/2010")
              page.summary = "testing man page"
              page.see_also do |also|
                also.reference "madeup", 4
                also.reference "rails", 1
                also.reference "ruby"
                also.reference "perl", 1
              end
              page.bugs = "There are a few bugs, but nothing too serious."
              page.history = "This program has a storied history that I am too lazy to include here."
            end
  end
  
  it "displays the correct date" do
    @rtfm.to_groff.should.match(/^.Dd January 02, 2010$/)
  end
  
  describe "see-also section" do
    it "has a see also section" do
      @rtfm.to_groff.should.match(/^.Sh SEE ALSO/)
    end
    
    it "includes references in its see also section" do
      groffed = @rtfm.to_groff
      groffed.should.match(/^.Xr rails 1$/)
      groffed.should.match(/^.Xr ruby$/)
      groffed.should.match(/^.Xr perl 1$/)
      groffed.should.match(/^.Xr madeup 4$/)
    end
    
    it "sorts by section" do
      groffed = @rtfm.to_groff
      groffed.index(/^.Xr ruby$/).should.be < groffed.index(/^.Xr rails 1$/)
      groffed.index(/^.Xr rails 1$/).should.be < groffed.index(/^.Xr madeup 4$/)
    end
    
    it "sorts within sections" do
      groffed = @rtfm.to_groff
      groffed.index(/^.Xr perl 1$/).should.be < groffed.index(/^.Xr rails 1$/)
    end
  end
  
  describe "rtfm-sections" do
    it "has a bugs section" do
      @rtfm.to_groff.should.match(/^.Sh BUGS$/)
    end
    
    it "includes its bugs text" do
      @rtfm.to_groff.should.match(/^There are a few bugs/)
    end
    
    it "has a history section" do
      @rtfm.to_groff.should.match(/^.Sh HISTORY$/)
    end
    
    it "includes its history text" do
      @rtfm.to_groff.should.match(/^This program has a storied history/)
    end
  end
end
