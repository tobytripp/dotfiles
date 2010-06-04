# Settings for non-login shells

# TODO: These PATH settings should be machine-specific
export JRUBY_HOME=/usr/local/lib/jruby
export MYSQL_HOME=/usr/local/mysql
export ANT_HOME=/opt/local/share/java/apache-ant
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export MONGODB_HOME=/usr/local/mongodb

export JEWELER_OPTS="--rspec"

PATH=~/bin:/usr/local/bin:/usr/local/sbin:$JAVA_HOME/bin:$JRUBY_HOME/bin:$MYSQL_HOME/bin:$MONGODB_HOME/bin:$PATH
PATH=$PATH:/usr/local/git/bin:/usr/local/ruby/bin

# MANPATH=/opt/local/share/man:$MANPATH

export EDITOR='mate -w'
export ARCHFLAGS="-arch x86_64"

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export ALTERNATE_EDITOR=""
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad

export CDPATH=:$HOME/Code/Ruby:$HOME/Code/ThoughtWorks/Code

# rvm-install added:
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

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
