# rtfm

This library intends to make it easy, using a spiffy DSL, to declaratively
create man files. The goal is also to have built-in rake tasks that you can
put into your Rakefile with just a `require "rtfm/rake"` that will add some
tasks for generating and installing your man files.

Eventually, I hope to see some of this work integrated into RubyGems, so that
developers can easily package man files with their gems.

## Example goal DSL:

    ManPage.new("testing", 2) do |page|
      page.summary = "testing man page"
      page.description do |desc|
        desc.body = "This is a small, temporary description of the testing " +
                    "man page."
        desc.add_option(:verbose, "The verbose flag does a lot of stuff.")
        desc.add_option(:input, "The input flag takes a filename", :argument => :input)
      end
      page.see_also do |also|
        also.reference "rails", 1
        also.reference "ruby"
      end
      page.bugs = "There are a few bugs, but nothing too serious."
      page.history = "This program has a storied history that I am too " +
                     "lazy to include here."
    end

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Michael Edgar. See LICENSE for details.
