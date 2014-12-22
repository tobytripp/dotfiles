# -*- mode: ruby -*-
require "rubygems" rescue nil

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
