require 'spec_helper'

describe "synopsis section" do
  
  before do
    @synopsis = SynopsisSection.new do |syno|
                  syno.option :r, "Some r flag"
                  syno.option :j, "Some j flag"
                  syno.option :k, "Some k flag"
                  syno.option :"0", "Some zero flag"
                  syno.option :A, "Some capitalized flag"
                  syno.option :Z, "some big-z flag"
                  syno.option :verbose, "The verbose flag does a lot of stuff."
                  syno.option :silliness, "Set how silly the application should be.", :argument => "n"
                  syno.option :input, "The input flag takes a filename", :argument => "<input>"
                end
    @groffed = @synopsis.to_groff
  end
  
  it "contains the name of the man page" do
    @groffed.should.match(/^\.Nm$/)
  end
  
  it "displays long-form flags" do
    @groffed.should.match(/^\.Op Fl verbose$/)
  end
  
  it "combines short-form flags into one entry" do
    @groffed.should.match(/^\.Op Fl ([rjk0AZ]{6})/)
  end
  
  it "sorts short-form flags within their entry" do
    @groffed.should.match(/AZjkr0/)
  end
  
  it "encodes < and > in option arguments" do
    @groffed.should.match(/Ao input Ac/)
  end
  
  it "underlines arguments" do
    @groffed.should.match(/\.Op Fl silliness Ar n/)
  end
end