begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new( :rubocop )
rescue LoadError
  # no rubocop
end
