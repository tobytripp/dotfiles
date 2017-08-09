# -*- mode: ruby -*-
module Toby
  module RakeUtil
    # Define the specified task iff it is not yet defined
    #
    def dtask( *args )
      task_n = case args.last
      when Hash
        args[-1].keys.first
      else
        args.first
      end

      return if Rake::Task.task_defined?( task_n )
      Rake::Task.define_task *args, &Proc.new
    end
  end
end

require "rake/clean"
include Toby::RakeUtil

$LOAD_PATH.unshift File.expand_path( "../.rakelib/", __FILE__ )
Dir[File.expand_path("~/.rakelib/**/*.rake")].map { |f| import f }
