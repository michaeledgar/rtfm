require 'spec_helper'

describe "description section" do
  
  FULL_DESC = "This is the description for the description section. Typically, this would" +
              " be much longer, but for now, it is short. Huzzah!"
  
  before do
    @desc = DescriptionSection.new do |desc|
              desc.body = FULL_DESC
              desc.option :verbose, "Makes output wordy and unnecessarily long"
              desc.option :input, "Specifies an input file", :arg => "<file>"
              desc.option :output, "Specifies an output file", :argument => "[output]"
              desc.option :silly, "Has a silly argument", :arg => "silliness"
              desc.option :d, "Doesn't actually do anything", :long => :"dry-run"
            end
    @groffed = @desc.to_groff
  end
  
  it "creates a description section" do
    @groffed.should.match /^\.Sh DESCRIPTION$/
  end
  
  it "displays its body below the section header" do
    @groffed.should.match /^\.Sh DESCRIPTION\n(?:\.Pp\n)?This is the/
  end
  
  it "contains the full body text" do
    @groffed.should.include FULL_DESC
  end
  
  it "creates a list for options" do
    @groffed.should.match /^\.Bl -tag/
  end
  
  it "creates list items with option names" do
    @groffed.should.match /^\.It Fl verbose/
    @groffed.should.match /^\.It Fl input/
  end
  
  it "displays arguments for options" do
    @groffed.should.match /^\.It Fl silly Ar silliness/
  end
  
  it "changes arguments with angle brackets to proper groff" do
    @groffed.should.match /Ao file Ac/
  end
  
  it "changes arguments with square brackets to proper groff" do
    @groffed.should.match /Oo output Oc/
  end
  
  it "puts option descriptions next to option names" do
    @groffed.should.match /^\.It Fl verbose\nMakes output wordy/
  end
  
  it "Uses two lines for flags with short and long names" do
    @groffed.should.match /^\.It Fl d\n/
    @groffed.should.match /^\.It Fl -dry-run\n/
  end
  
end
