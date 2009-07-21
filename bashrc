# Settings for non-login shells
export JRUBY_HOME=/usr/local/lib/jruby
export MYSQL_HOME=/usr/local/mysql
export ANT_HOME=/opt/local/share/java/apache-ant
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home

# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=~/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$JAVA_HOME/bin:$JRUBY_HOME/bin:$MYSQL_HOME/bin:$PATH
PATH=$PATH:/usr/local/git/bin:/usr/local/ruby/bin

MANPATH=/opt/local/share/man:$MANPATH

export EDITOR=vim

source ~/.history

source ~/.terminal_colors