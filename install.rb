#!/usr/bin/env ruby
require 'yaml'

home = File.expand_path('~')
backup = File.join(home, ".backup")
Dir.mkdir backup unless File.exists? backup

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
  settings = {}
  puts "What should I call your user profile? "
  user_profile = gets.chomp
  puts "Awesome, I will create #{user_profile}"
  puts "A sample user profile will be created for you in dotfiles/user_specific/#{user_profile}"
  puts "you can override all the environment variables specified in dotfiles/os_specific/<your_os>/environment"
  puts "you can also override or preempt path set in dotfiles/os_specific/<your_os>/paths"
  Dir.mkdir "user_specific/#{user_profile}"
  File.open("user_specific/#{user_profile}/loader", "w") do |file|
    file.write("source ~/.user_specific/environment \n")
    file.write("source ~/.user_specific/paths \n")
    file.write("source ~/.user_specific/aliases \n")
  end
  
  File.open("user_specific/#{user_profile}/environment", "w") do |file|
    file.write("export EDITOR=vim")
  end

  File.new("user_specific/#{user_profile}/paths", "w")
  File.new("user_specific/#{user_profile}/aliases", "w")

  puts "We will also setup a default ~/.gitconfig for you... you can change the settings from dotfiles/user_specific/#{user_profile}/gitconfig"
  puts "What do you want your full name to be for git? "
  git_full_name = gets.chomp
  puts "What is the email you want to use for git? "
  git_email = gets.chomp
  gitconfig_template = File.read("templates/gitconfig")
  gitconfig = gitconfig_template.gsub(/<FULL_NAME>/, git_full_name).gsub(/<EMAIL>/, git_email)
  File.open("user_specific/#{user_profile}/gitconfig", "w") do |file|
    file.write(gitconfig)
	end
  puts "Would you like for us provide you with a powerful vim configuration, carlhuda's janus (Y/n)? "
  janus = gets.chomp.upcase
  settings['janus'] = janus == "" || janus == "Y" || janus == "YES"
  File.open("user_specific/#{user_profile}/settings.yaml", "w") do |file|
    file.write(YAML::dump(settings))
  end
else
  puts "Wicked!  I will set you up with #{user_profile}"
end

user_settings = {}
if File.exists?("user_specific/#{user_profile}/settings.yaml")
  File.open("user_specific/#{user_profile}/settings.yaml", "r").each do |object|
    user_settings = YAML::load(object)
  end
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

`ln -s #{File.expand_path "user_specific/"}/#{user_profile}/gitconfig #{home}/.gitconfig`

if File.exist?("emacs-starter-kit")
  target = File.join(home, ".emacs.d")
  `ln -s #{File.expand_path "emacs-starter-kit/"} #{target}`
end

if user_settings['janus']
  `git submodule update --init`
  Dir.chdir("bash_boost/janus")
  `rake`
  `git submodule foreach git clean -f`
  Dir.chdir("../..")
end
