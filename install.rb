#!/usr/bin/env ruby

home = File.expand_path('~')

target = File.join(home, ".os_specific")
if RUBY_PLATFORM =~ /Darwin/i
  `ln -s #{File.expand_path "os_specific/darwin/"}/ #{target}`
else
  `ln -s #{File.expand_path "os_specific/linux/"}/ #{target}`
end

Dir.chdir("the_files")
Dir['*'].each do |file|
  next if file =~ /install/
  target = File.join(home, ".#{file}")
  `ln -s #{File.expand_path file} #{target}`
end


# git push on commit
#`echo 'git push' > .git/hooks/post-commit`
#`chmod 755 .git/hooks/post-commit`
