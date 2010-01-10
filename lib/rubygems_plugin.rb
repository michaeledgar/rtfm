require 'rubygems/command_manager'

require 'rubygems/command'
require 'rubygems_analyzer'

class Gem::Commands::ManCommand < Gem::Command

  def initialize
    super 'man', 'Manage man-files bundled with gems'
  end

  def execute
    require 'pp'
    pp options
  end

end

Gem::CommandManager.instance.register_command :man

