#!/usr/bin/env ruby
require 'yaml'

backup = File.join(home, ".backup")
Dir.mkdir backup unless File.exists? backup

`mkdir #{backup}`
Dir.chdir("the_files")
Dir["*"].each do |file|
  target = File.join(home, ".#{file}")
  `mv -f #{target} #{backup}`
  `ln -s #{File.expand_path file} #{target}`
end
