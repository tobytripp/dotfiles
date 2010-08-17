require "rubygems" rescue nil
require "wirble"
require "looksee/shortcuts" rescue nil
require 'hirb'

require 'what_methods'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

Wirble.init
Wirble.colorize

# hirb (active record output format in table)
Hirb::View.enable

# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>> 
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_I => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

# We can also define convenient methods (credits go to thoughtbot)
def me
  User.find_by_email("me@gmail.com")
end
