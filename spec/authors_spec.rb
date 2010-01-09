require 'spec_helper'

describe "authors section" do
  before do
    @authors = AuthorsSection.new do |sect|
                 sect.author "Michael Edgar"
                 sect.author "Ari Brown", "seydar@carboni.ca"
               end
    @groffed = @authors.to_groff
  end
  
  it "makes an authors section" do
    @groffed.should.match(/^\.Sh AUTHORS$/)
  end
  
  it "adds an author without an email" do
    @groffed.should.match(/^\.An "Michael Edgar"$/)
  end
  
  it "adds an author with an email" do
    @groffed.should.match(/^\.An "Ari Brown" Aq seydar@carboni.ca/)
  end
end