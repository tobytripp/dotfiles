#!/usr/bin/env ruby

home = File.expand_path('~')
backup = File.join(home, "backup")

`mkdir #{backup}`
Dir.chdir("the_files")
Dir["*"].each do |file|
  target = File.join(home, ".#{file}")
  `mv -f #{target} #{backup}`
  `ln -s #{File.expand_path file} #{target}`
end

Dir.chdir("..")
BASH_BOOST = "bash_boost"
target = File.join(home, ".#{BASH_BOOST}")
`ln -s #{File.expand_path BASH_BOOST} #{target}`

target = File.join(home, ".os_specific")
if RUBY_PLATFORM =~ /Darwin/i
  `ln -s #{File.expand_path "os_specific/darwin/"}/ #{target}`
else
  `ln -s #{File.expand_path "os_specific/linux/"}/ #{target}`
end
               
# git push on commit
#`echo 'git push' > .git/hooks/post-commit`
#`chmod 755 .git/hooks/post-commit`
