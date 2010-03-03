# Settings for non-login shells
export JRUBY_HOME=/usr/local/lib/jruby
export MYSQL_HOME=/usr/local/mysql
export ANT_HOME=/opt/local/share/java/apache-ant
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export MONGODB_HOME=/usr/local/mongodb

export JEWELER_OPTS="--rspec"

# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=~/bin:/usr/local/bin:/usr/local/sbin:$JAVA_HOME/bin:$JRUBY_HOME/bin:$MYSQL_HOME/bin:$MONGODB_HOME/bin:$PATH
PATH=$PATH:/usr/local/git/bin:/usr/local/ruby/bin

# MANPATH=/opt/local/share/man:$MANPATH

export EDITOR='mate -w'
export ARCHFLAGS="-arch x86_64"

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export TERM=xterm-color
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad

export CDPATH=:$HOME/Code/Ruby:$HOME/Code/ThoughtWorks/Code

source ~/bin/cdargs-bash.sh

# rvm-install added line:
# if [[ -s $HOME/.profile ]] ; then source $HOME/.profile ; fi

# rvm-install added:
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
