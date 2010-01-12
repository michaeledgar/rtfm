require 'spec_helper'

describe "a groffable paragraph" do
  
  before do
    @paragraph = Paragraph.new("This is a small, temporary description of the testing " +
                "man page. I'm going to fill in some totally *random*. text here that " +
                "nobody is **ever** going to pay attention to! In fact, I think _this_ is " +
                "the dumbest paragraph __ever__.")
    @groffed = @paragraph.to_groff
  end
  
  it "adds a paragraph macro when groffed" do
    @groffed.should.match /^\.Pp\n/
  end
  
  it "places the text directly beneath the section header" do
    @groffed.should.match /\.Pp\nThis is a small/
  end
  
  it "converts text wrapped in asterisks to bold" do
    @groffed.should.match /totally\s*\n\.Sy random\s*\n/
  end
  
  it "converts text wrapped in two asterisks to underline" do
    @groffed.should.match /is\s*\n\.Em ever\s*\ngoing/
  end
  
  it "converts text wrapped in underscores to bold" do
    @groffed.should.match /think\s*\n\.Sy this\s*\nis/
  end
  
  it "converts text wrapped in two underscores to underline" do
    @groffed.should.match /paragraph\s*\n\.Em ever\s*\n/
  end
  
  it "does not place a period at the start of a line" do
    @groffed.should.not.match /^\.(\s|$)/
  end
end