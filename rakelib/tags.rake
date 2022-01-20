# -*- mode: ruby -*-

begin
  require "diff/lcs"
rescue LoadError
end

namespace :tags do
  EXCLUDES = %w[vendor bundle chef].map { |d|  "--exclude=#{d}" }

  PATHS = FileList.new
  PATHS.include "."
  TAG_FILE = ".TAGS"

  def diff( a, b )
    if defined? Diff
      Diff::LCS.diff( File.read( a ).lines,
                      File.read( b ).lines ).empty?
    else
      system "diff", "-q", a, b
    end
  end

  file TAG_FILE => SOURCES.exclude( "**/*_spec.rb" ) do |t|
    cp TAG_FILE, ".TAGS.last" if File.exist? TAG_FILE
    sh( *["ripper-tags", "-R", EXCLUDES, "-ef", ".TAGS", PATHS.to_a].flatten )
    unless diff( TAG_FILE, ".TAGS.last")
      sh( %{emacsclient -e '(visit-project-tags)'} )
    end
    rm_f ".TAGS.last"
  end

  desc "Generate ctags index in emacs format in file: ./.TAGS"
  task :emacs => TAG_FILE

  desc "Tag bundled gems"
  task :gems => :emacs do
    gems = FileList[`bundle show --paths`.lines.map( &:rstrip )]
    mkdir_p ".gem-tags"
    gems.each do |gem|
      sh( "ripper-tags", "-ef", ".gem-tags/#{File.basename gem}.tags", gem )
    end
  end

  desc "Generate ctags index in emacs format in file: ./.TAGS"
  task tags: "tags:emacs"
end

