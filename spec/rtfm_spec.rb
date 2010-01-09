require 'spec_helper'

describe "rtfm" do
  before do
    @rtfm = ManPage.new("testing", 2) do |page|
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
    @groff = @rtfm.to_groff
  end
  
  it "displays the correct date" do
    @groff.should.match(/^\.Dd January 02, 2010$/)
  end
  
  it "has a NAME section" do
    @groff.should.match(/^\.Sh NAME$/)
  end
  
  it "generates a name line" do
    @groff.should.match(/^\.Nm testing/)
  end
  
  it "generates a summary line" do
    @groff.should.match(/^\.Nd testing man page/)
  end
  
  describe "rtfm-sections" do
    it "has a bugs section" do
      @groff.should.match(/^\.Sh BUGS$/)
    end
    
    it "includes its bugs text" do
      @groff.should.match(/^There are a few bugs/)
    end
    
    it "has a history section" do
      @groff.should.match(/^\.Sh HISTORY$/)
    end
    
    it "includes its history text" do
      @groff.should.match(/^This program has a storied history/)
    end
  end
end
