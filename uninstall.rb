#!/usr/bin/env ruby

home = File.expand_path('~')
backup = File.join(home, "backup")

#find all files pointing to dotfiles and remove them

`find . -maxdepth 1 -type lname -ls | grep dotfiles `

Dir.chdir(home)
# Dir["*"].each do |file|
#   `rm #{File.expand_path file}`
# end

#remove bashboost and os_specific
`rm #{File.join(home, ".bash_boost")}`

target = File.join(home, ".os_specific")
`rm #{target}`

# restore whatever was in the backup