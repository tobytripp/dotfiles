# Put /usr/local/bin ahead of /usr/bin to preempt built-in Ruby
PATH=/usr/local/bin:$PATH

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
