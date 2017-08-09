# -*- mode: ruby -*-

begin
  require "pry"
  Pry.start
  exit
rescue LoadError
  $stderr.puts "Pry not available, falling back to irb"
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
  require "irb/completion"
  IRB.conf[:PROMPT_MODE] = :SIMPLE
  IRB.conf[:AUTO_INDENT] = true
end
