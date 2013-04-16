# -*- mode: ruby -*-
require "rubygems" rescue nil

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

begin
  %w{looksee/shortcuts what_methods wirble}.each { |lib| require lib }

  Wirble.init
  Wirble.colorize
rescue LoadError => e
  warn "Could not load library: #{e}"
end
