export JRUBY_HOME=/usr/local/lib/jruby
export MYSQL_HOME=/usr/local/mysql
export ANT_HOME=/opt/local/share/java/apache-ant
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home

# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=~/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$JAVA_HOME/bin:$JRUBY_HOME/bin:$MYSQL_HOME/bin:$PATH
MANPATH=/opt/local/share/man:$MANPATH

export EDITOR=vim
export TERM=xterm-color
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

source ~/.bash_vcs.sh

_mategem()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}
complete -F _mategem -o dirnames mategem
