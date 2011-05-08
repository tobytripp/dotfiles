#!/usr/bin/env ruby

home = File.expand_path('~')
backup = File.join(home, ".backup")

puts "Removing bash_boost... Sorry to see you go :("
`rm #{File.join(home, ".bash_boost")}`

puts "Removing os_specific settings. Your paths may need tweaking after this step."
target = File.join(home, ".os_specific")
`rm #{target}`

#find all files pointing to dotfiles and remove them
# when doing it with bash we will need to do it with find
# SYMLINKS=`find . -maxdepth 1 -type lname -ls | grep dotfiles `

# puts SYMLINKS
Dir.foreach( home ) do | symlink |
  File.delete( "#{home}/#{symlink}" ) if File.ftype( "#{home}/#{symlink}" ) == "link"
end

# restore whatever was in the backup
Dir.foreach( backup ) do | symlink |
  `mv #{symlink} ~`
end