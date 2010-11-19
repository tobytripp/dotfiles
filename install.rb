#!/usr/bin/env ruby

home = File.expand_path('~')
backup = File.join(home, "backup")

puts "Hey"
puts "So, BashBoost eh?"
puts "Nice!"
user_directories = Dir.entries('user_specific').delete_if { |thing| !File::directory?("user_specific/#{thing}") || thing == "." || thing == ".."}

if !user_directories.empty?
  puts "I know about the following user profiles:" 
  count = 1
	user_directories.each do |directory| 
	  puts "#{count}) #{directory}"
		count += 1
	end
  puts "Select the number that you would like to use, or press Enter to create a new one "
	user_profile_selection = gets.chomp
	user_profile = user_directories[user_profile_selection.to_i-1] unless user_profile_selection.to_i == 0
end

if user_profile.nil?
  puts "What should I call your user profile? "
  name = gets.chomp
  puts "Awesome, I will create #{name}"
  Dir.mkdir "user_specific/#{name}"
  File.new("user_specific/#{name}/loader", "w") do |file|
    file.syswrite("source ~/.user_specific/paths")
  end
  File.new("user_specific/#{name}/paths", "w")
else
  puts "Wicked!  I will set you up with #{user_profile}"
end


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

target = File.join(home, ".user_specific")
`ln -s #{File.expand_path "user_specific/"}/#{user_profile}/ #{target}`

# git push on commit
#`echo 'git push' > .git/hooks/post-commit`
#`chmod 755 .git/hooks/post-commit`
