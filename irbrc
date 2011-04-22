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

IRB.conf[:IRB_RC] = Proc.new do
  require 'console_helper' if ENV['RAILS_ENV']
  fsuc
  OWNER = Owner.find 7
  COMMAND = BackstopDataDownload::HoldingDetailsImportCommand.new 20.years.ago, Time.now, OWNER
end
