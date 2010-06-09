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
export JEWELER_OPTS="--rspec"

source ~/.history

source ~/.terminal_colors

if [[ -s /Users/ThoughtWorks/.rvm/scripts/rvm ]] ; then 
  source /Users/ThoughtWorks/.rvm/scripts/rvm ; 
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then 
  source "$HOME/.rvm/scripts/rvm" ; 

export ALTERNATE_EDITOR=""
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad

SCRIPT_PATH="${BASH_SOURCE[0]}"
if [[ -h $SCRIPT_PATH ]] ; then
    while [[ -h $SCRIPT_PATH ]] ; do SCRIPT_PATH=`readlink $SCRIPT_PATH`; done
fi

SCRIPT_DIR=`dirname $SCRIPT_PATH`

# Load host-specific settings, if any
if [[ -d $SCRIPT_DIR/`hostname` ]]; then
    HOST_SETTINGS_DIR=$SCRIPT_DIR/`hostname`
elif [[ -d $HOME/.`hostname` ]]; then
    HOST_SETTINGS_DIR=$HOME/.`hostname`
fi

if [[ -d $HOST_SETTINGS_DIR ]] ; then
    for file in $HOST_SETTINGS_DIR/*; do source $file; done
fi

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session. Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
    STARTED_SCREEN=1 ; export STARTED_SCREEN
    [ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
    sleep 1
    screen -RR && exit 0
    
    # normally, execution of this rc script ends here...
    echo "Screen failed! continuing with normal bash startup"
fi
