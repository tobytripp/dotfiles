require "rubygems" rescue nil
require "wirble"
require "looksee/shortcuts" rescue nil

require 'what_methods'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

Wirble.init
Wirble.colorize
