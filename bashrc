# Settings for non-login shells
export JRUBY_HOME=/usr/local/lib/jruby
export MYSQL_HOME=/usr/local/mysql
export ANT_HOME=/opt/local/share/java/apache-ant
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export BUILT_IN_RUBY=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin
export GITERNAL=~/projects/rackspace.git/giternal
export MONGODB=~/mongodb-osx-i386-1.4.3

# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=~/bin:/usr/local/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:$JAVA_HOME/bin:$MYSQL_HOME/bin:$PATH
PATH=$PATH:/usr/local/git/bin:$BUILT_IN_RUBY:$JRUBY_HOME/bin
PATH=$PATH:/usr/local/git/libexec/git-core/:$GITERNAL/bin
PATH=$PATH:$MONGODB/bin

MANPATH=/opt/local/share/man:$MANPATH

export EDITOR=vim

source ~/.history

source ~/.terminal_colors

if [[ -s /Users/ThoughtWorks/.rvm/scripts/rvm ]] ; then 
  source /Users/ThoughtWorks/.rvm/scripts/rvm ; 
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then 
  source "$HOME/.rvm/scripts/rvm" ; 
fi
