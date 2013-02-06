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

export EDITOR=e
export BUNDLER_EDITOR='emacsclient -a "" -n'
export LANG=en_US.UTF-8


source $HOME/.ssh_agent.sh

if [ -f ${BASH}/bash_it.sh ]; then
    source ${BASH}/bash_it.sh
fi

export NODE_PATH="/usr/local/lib/node/"
export NODE_NO_READLINE=1
if [[ -d $NODE_PATH ]]; then
    export PATH=/usr/local/share/npm/bin:$PATH
fi

export CFLAGS=-Wno-error=shorten-64-to-32
export RUBY_CONFIGURE_OPTS=--with-openssl-dir=`brew --prefix openssl`
export CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline`

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[[ -d $HOME/bin/magic-dollar ]] && export PATH=$PATH":$HOME/bin/magic-dollar"
