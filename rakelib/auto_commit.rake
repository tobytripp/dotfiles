# -*- coding: utf-8; mode: ruby -*-
# frozen_string_literal: true

MESSAGE_FILE = ".AUTO_COMMIT_EDIT_MSG"
PROGRAM_TEMPLATE = <<EMACS_LISP
(let ((directory "<%= dir %>")
      (msg-log   "<%= template %>"))
  (select-frame-set-input-focus (selected-frame))
  (with-temp-buffer
    (cd directory)
    (save-some-buffers)
    (magit-stage-modified)
    (magit-commit (list "-a" "-F" msg-log <%= arguments %>)))
  (setq auto-commit-msg-buf (find-file msg-log))
  (erase-buffer)
  (insert (ring-ref log-edit-comment-ring 0))
  (save-buffer)
  (kill-buffer auto-commit-msg-buf))
EMACS_LISP

def do_commit( *args )
  template  = File.expand_path MESSAGE_FILE
  dir       = File.dirname template
  arguments = args.map( &:inspect ).join " "

  program =  ERB.new( PROGRAM_TEMPLATE ).
               result( binding ).
               lines.
               map( &:lstrip ).
               map( &:rstrip ).
               join( " " )

  sh "emacsclient -e '#{program}'" do |ok, res|
    $stderr.puts " --- Emacs said NO." if !ok
  end
end

file MESSAGE_FILE => ".spec.last_push" do |t|
  File.open( t.name, "w" ) do |f|
    f.puts "#{ENV["LOGNAME"]}: Tests passing [TRACKER_ID]"
    f.puts
  end

  do_commit "-e"
end

desc "Commit current changes via magit"
task :commit do
  if (t = Rake::Task[MESSAGE_FILE]).needed?
    t.invoke
  else
    do_commit
  end
end

require "rake/tasklib"
module Toby
  module AutoCommit
    class RakeTask < ::Rake::TaskLib
      include ::Rake::DSL if defined?(::Rake::DSL)

      # The `sentinel' file paths that track test success
      attr_accessor :unit_sentinel, :acceptance_sentinel

      DEFAULT_SOURCES = Rake::FileList["lib/**/*.rb", "app/**/*.rb"]
      # FileList or pattern to find source code
      attr_accessor :sources

      DEFAULT_UNITS = Rake::FileList["spec/lib/**/*_spec.rb"]
      # FileList or pattern to find unit-test code
      attr_accessor :unit_specs

      DEFAULT_ACCEPTANCE =
        Rake::FileList["spec/features/**/*_spec.rb", "features/**/*.feature"]
      # FileList or pattern to find acceptance-test code
      attr_accessor :acceptance_specs

      # Test command to run
      attr_accessor :command

      def initialize( *args, &task_block )
        @name = args.shift || :checkin
        @sources          = DEFAULT_SOURCES
        @acceptance_specs = DEFAULT_ACCEPTANCE
        @unit_specs       = DEFAULT_UNITS.exclude( acceptance_specs )

        define( args, &task_block )
      end

      private

      def define( args, &task_block )
        desc "Run tests and auto-commit on success" unless ::Rake.application.last_description
        task name, *args do |_, task_args|
          RakeFileUtils.__send__(:verbose, verbose) do
            task_block.call(*[self, task_args].slice(0, task_block.arity)) if task_block
            run_task verbose
          end
        end
      end
    end
  end
end

SOURCES          = Rake::FileList["lib/**/*.rb", "app/**/*.rb"]
ACCEPTANCE_SPECS =
  Rake::FileList["spec/features/**/*_spec.rb", "features/**/*.feature"]
UNIT_SPECS       =
  Rake::FileList["spec/lib/**/*_spec.rb"].exclude ACCEPTANCE_SPECS

unless Rake::Task.task_defined?( ".spec.unit.passed" )
  file ".spec.unit.passed" => [*SOURCES, *UNIT_SPECS] do |t|
    Rake::Task["spec:unit"].invoke
    File.open( t.name, "a" ) { |f| f.puts Time.now.iso8601 }
  end
end

unless Rake::Task.task_defined?( ".spec.acceptance.passed" )
  file ".spec.acceptance.passed" => [".spec.unit.passed", *ACCEPTANCE_SPECS] do |t|
    if Rake::Task.task_defined?( "spec:pacceptance" )
      Rake::Task["spec:pacceptance"].invoke 8
    else
      Rake::Task["spec:acceptance"]
    end
    File.open( t.name, "a" ) { |f| f.puts Time.now.iso8601 }
  end
end

file ".spec.last_push" => [".spec.acceptance.passed"] do |t|
  `emacsclient -e '(magit-status)'`
  File.open( t.name, "a" ) { |f| f.puts Time.now.iso8601 }
end

namespace :spec do
  desc "Run unit specs, commit changes on pass (via magit)"
  task :checkin => [:clean, ".spec.unit.passed", :commit]

  desc "if unit and acceptance specs pass, push changes (via magit)"
  task :push    => [".spec.last_push"]

  if defined? RSpec
    desc "Run acceptance specs"
    RSpec::Core::RakeTask.new( :acceptance ) do |t|
      t.pattern    = "{,spec/}features/**/*_spec.rb"
      t.rspec_opts = "--format documentation"
      if ENV["GUARD_NOTIFIERS"]
        t.rspec_opts += " -r guard/rspec_formatter --format Guard::RSpecFormatter"
      end
    end
  end
end
