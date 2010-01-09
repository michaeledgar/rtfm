# rtfm

Using RTFM, you can declaratively create nice, standard man pages for your
Ruby projects using a slick, maintainable DSL. It also includes rake tasks
to aid in debugging, generating, and installing your man files.

## Normal manfiles are... interesting

You might say: "but wait, aren't man pages already written in a DSL?", and you'd
be right! However, here's an example of it:

    .It Fl p
    Acts mostly same as -n switch, but print the value of variable
    .Li "$_"
    at the each end of the loop.  For example:
    .Bd -literal -offset indent
    % echo matz | ruby -p -e '$_.tr! "a-z", "A-Z"'
    MATZ
    .Ed
    .Pp
    .It Fl r Ar library
    Causes Ruby to load the library using require.  It is useful when using
    .Fl n
    or
    .Fl p .

That's from the Ruby manfile. This is using the `groff` macro language,
which is awfully spiffy. However, it makes man files extremely tedious to
maintain. It even spits out errors if you put a blank line in your manfile!

## A word of caution

Now, manfiles are long and complex, and contain a lot of information. Chances
are, your RTFM-based manfile isn't actually going to be too much shorter than
your normal groff-based entry. The difference is that by using the RTFM
DSL, it should be very, very simple to maintain. Which is a huge
win for your users.

## Example Manual Page:

    RTFM::ManPage.new("testing", 2) do |page|
      page.summary = "testing man page"
      page.option :verbose, "The verbose flag does a lot of stuff."
      page.option :silliness, "Set how silly the application should be.", :argument => "n"
      page.option :input, "The input flag takes a filename", :argument => "<input>"
      
      page.description do |desc|
        desc.body = "This is a small, temporary description of the testing " +
                    "man page."
      end
      page.see_also do |also|
        also.reference "rails", 1
        also.reference "ruby"
      end
      page.bugs = "There are a few bugs, but nothing too serious."
      page.history = "This program has a storied history that I am too " +
                     "lazy to include here."
      page.authors do |authors|
        authors.add "Michael Edgar", "adgar@carboni.ca"
      end
    end

## Other wins

The weird thing about making manfiles is that each section has its own semantics -
sometimes, macros even change their meanings slightly. There are idioms and "best practices"
for each. The cool part of RTFM is that we can try to match the idioms for you - you
just provide the information we need.

An example: in the "SEE ALSO" section, you can provide a list of other manual pages
that are related to yours. In the example above, you see a couple of simple references.
If you read the deep, dark documentation on the subject, you'll know that these references
should be sorted by manual section, and then alphabetically within sections. RTFM will do that 
for you. It's the little things that count.

## Upcoming

Hopefully we can get some of this integrated into RubyGems, though that's a long shot - 
it's a long-standing, cross-platform project. But it's nice to dream.

I hope to add the ability to insert raw groff if you are an advanced user and want some
really spiffy formatting.

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
