#!/bin/bash
source $HOME/.bashrc

source $HOME/.bash_vcs.sh
source $HOME/.bash_login

source $HOME/.jumplist/j.sh
source $HOME/.mategem.sh

source $HOME/bin/cdargs-bash.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

source $HOME/.ssh_agent.sh

# http://github.com/revans/bash-it
export BASH=$HOME/.bash_it
export BASH_THEME='clean'
export EDITOR="/usr/bin/mate -w"
export GIT_EDITOR='/usr/bin/mate -w'
unset MAILCHECK

if [ -f ${BASH}/bash_it.sh ]; then
  source ${BASH}/bash_it.sh
fi

export NODE_PATH="/usr/local/lib/node/"
if [[ -d $NODE_PATH ]]; then
  export PATH=/usr/local/share/npm/bin:$PATH
fi
