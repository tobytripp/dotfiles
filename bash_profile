# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=/usr/local/bin:$PATH

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

source .bash_vcs.sh

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
