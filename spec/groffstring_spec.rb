require 'spec_helper'

describe "groff_string" do
  before do
    @groff = GroffString.new
    @groff_with_line = GroffString.new("Some text")
  end
  
  it "uses its initial value" do
    @groff.to_s.should.equal ""
    @groff_with_line.to_s.should.equal("Some text")
  end
  
  it "converts to a string" do
    @groff.should.respond_to(:to_s)
  end
  
  it "adds references using the .Xr macro" do
    @groff.reference("rails", 1)
    @groff.to_s.should.include(".Xr rails 1")
  end
  
  it "generates sections" do
    @groff.section("NAME")
    @groff.to_s.should.include(".Sh NAME")
  end
  
  it "generates arbitrary macros" do
    @groff.Br("some", "arguments", :here)
    @groff.to_s.should.include(".Br some arguments here")
  end
  
  it "adds lines using add_line" do
    @groff.add_line("some arbitrary line goes here")
    @groff.to_s.should.include("some arbitrary line goes here\n")
  end
  
  it "adds lines with <<" do
    @groff << "werd some line"
    @groff.to_s.should.include("werd some line\n")
  end
end