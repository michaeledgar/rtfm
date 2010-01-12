require 'rubygems/command_manager'

require 'rubygems/command'

class Gem::Commands::ManCommand < Gem::Command

  def initialize
    super 'man', 'Manage man-files bundled with gems'
    options[:action] = :install
    
    add_option('-v', '--view', "Views the manual files included in",
                               "the gem.") do |value, options|
      options[:action] = :view
    end
    
    add_option('-i', '--install', "Installs all the gem's manual files globally") do |value, options|
      options[:action] = :install
    end
    
    add_option('-r', '--remove', "Removes the gem's manual files globally") do |value, options|
      options[:action] = :remove
    end
  end

  def execute
    if Gem.win_platform? || !has_man?
      alert_error "You must have the 'man' command to use this extension."
      return
    end
    
    get_all_gem_names.each do |name|
      path = get_path name, options[:version]
      if path then
        man_path = File.join path, 'man'
        if File.exist?(man_path) && File.directory?(man_path) then
          Dir[File.join(man_path, "**")].each do |man_file|
            dispatch(man_file)
          end
        else
          alert_error "Gem '#{name}' does not appear to have packaged man files."
        end
      else
        alert_error "Gem '#{name}' not installed."
      end
    end
  end

  
  def dispatch(file)
    case options[:action]
    when :install
      install(file)
    when :view
      view(file)
    when :remove
      remove(file)
    end
  end
  
  MAN_DIR = "/usr/share/man/"
  
  ##
  # Views the man file in the man program
  def view(source)
    system("man #{source}")
  end
  
  ##
  # Installs the given file into the appropriate man directory.
  def install(source)
    full_name = File.split(source).last
    section = full_name.split(".").last
    destination = File.join MAN_DIR, "man#{section}", full_name
    File.open(destination, "wb") do |out|
      out << watermark_file(source)
    end
  end
  
  ##
  # Installs the given file into the appropriate man directory.
  def remove(source)
    full_name = File.split(source).last
    section = full_name.split(".").last
    destination = File.join MAN_DIR, "man#{section}", full_name
    if is_watermarked_file?(destination)
      FileUtils.unlink(destination)
    else
      alert_error "The man file at #{destination} was not installed by Rubygems. It has "+
                  "not been deleted."
    end
  end
  
  def watermark
    %Q{.\\" Installed by Rubygems' Man Extension\n}
  end
  
  ##
  # Watermarks a man page. Assumes input file is not already compressed.
  def watermark_file(file)
    add_watermark(File.read(file))
  end
  
  ##
  # Watermarks some groff text, so you can tell it's been rubygem'd
  def add_watermark(text)
    "#{watermark}#{text}"
  end
  
  ##
  # Watermarks a man page. Assumes input file is not already compressed.
  def is_watermarked_file?(file)
    is_watermarked?(File.read(file))
  end
  
  ##
  # Is the given text watermarked?
  def is_watermarked?(text)
    text[0..(watermark.size-1)] == watermark
  end
  
  # Return the full path to the cached gem file matching the given
  # name and version requirement.  Returns 'nil' if no match.
  #
  # Example:
  #
  #   get_path('rake', '> 0.4')   # -> '/usr/lib/ruby/gems/1.8/cache/rake-0.4.2.gem'
  #   get_path('rake', '< 0.1')   # -> nil
  #   get_path('rak')             # -> nil (exact name required)
  #--
  # TODO: This should be refactored so that it's a general service. I don't
  # think any of our existing classes are the right place though.  Just maybe
  # 'Cache'?
  #
  # TODO: It just uses Gem.dir for now.  What's an easy way to get the list of
  # source directories?
  def get_path(gemname, version_req)
    return gemname if gemname =~ /\.gem$/i

    specs = Gem::source_index.find_name gemname, version_req

    selected = specs.sort_by { |s| s.version }.last

    return nil if selected.nil?

    # We expect to find (basename).gem in the 'cache' directory.
    # Furthermore, the name match must be exact (ignoring case).
    if gemname =~ /^#{selected.name}$/i
      filename = selected.full_name
      path = nil

      Gem.path.find do |gem_dir|
        path = File.join gem_dir, 'gems', filename
        File.exist? path
      end

      path
    else
      nil
    end
  end

  def has_man?
    system("man 1>/dev/null 2>&1")
  end

end

Gem::CommandManager.instance.register_command :man

