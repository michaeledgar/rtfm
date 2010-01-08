require 'spec_helper'

describe "rtfm" do
  before do
    @rtfm = ManPage.new("testing") do |page|
              page.date = Date.parse("1/2/2010")
              page.summary = "testing man page"
              page.see_also do |also|
                also.reference "rails", 1
                also.reference "ruby"
              end
              page.bugs = "There are a few bugs, but nothing too serious."
              page.history = "This program has a storied history that I am too lazy to include here."
            end
  end
  
  it "displays the correct date" do
    @rtfm.to_groff.should.match(/^.Dd January 02, 2010$/)
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
    
    it "has a see also section" do
      @rtfm.to_groff.should.match(/^.Sh SEE ALSO/)
    end
    
    it "includes references in its see also section" do
      @rtfm.to_groff.should.match(/^.Xr rails 1$/)
      @rtfm.to_groff.should.match(/^.Xr ruby$/)
    end
  end
end
