require 'spec_helper'

describe "the files section" do
  
  before do
    @files = FilesSection.new do |files|
               files.add("/etc/sshrc", "Commands in this file are executed by ssh "+
                                       "when the user logs in, just before the user's "+
                                       "shell (or command) is started.")
               files.add("/etc/shosts.equiv", "This file is used in exactly the same way as "+
                                              "hosts.equiv, but allows host-based authentication "+
                                              "without permitting login with rlogin/rsh.")
             end
    @groffed = @files.to_groff
  end
  
  it "sorts by filename" do
    @groffed.index("/etc/sshrc").should.be > @groffed.index("/etc/shosts.equiv")
  end
  
  it "creates a tagged-list sized by the largest filename" do
    @groffed.should.match(/#{"/etc/shosts.equiv".size}n/)
  end
  
  it "closes its list" do
    @groffed.should.match(/^\.El$/)
  end
  
  it "puts filenames on an Item line" do
    @groffed.should.match(/^\.It \/etc\/sshrc$/)
  end
end