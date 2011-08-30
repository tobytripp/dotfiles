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

source ~/.prompt.sh

if [ -f ~/.oraclerc ]; then
    source ~/.oraclerc
fi

export EDITOR='emacsclient -a ""'
export BUNDLER_EDITOR='emacsclient -a "" -n'

source $HOME/.ssh_agent.sh

if [ -f ${BASH}/bash_it.sh ]; then
    source ${BASH}/bash_it.sh
fi

export NODE_PATH="/usr/local/lib/node/"
if [[ -d $NODE_PATH ]]; then
    export PATH=/usr/local/share/npm/bin:$PATH
fi

[[ -d $HOME/bin/magic-dollar ]] && export PATH=$PATH":$HOME/bin/magic-dollar"
