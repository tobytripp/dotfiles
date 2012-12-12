#!/bin/bash

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Settings for non-login shells
export JEWELER_OPTS="--rspec"

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:w:* --help"
export HISTTIMEFORMAT='%F %T '
shopt -s histappend

export ALTERNATE_EDITOR=""
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad

export ARCHFLAGS="-arch x86_64"

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

# rvm-install added:
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

NODE_BIN=/usr/local/share/npm/bin
NODE_LIB=/usr/local/lib/node
if [[ -s $NODE_BIN ]]; then export PATH=$NODE_BIN:$PATH; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
CABAL_BIN=$HOME/.cabal/bin
if [[ -s $CABAL_BIN ]]; then export PATH=$CABAL_BIN:$PATH; fi

export PATH=~/bin:/usr/local/bin:$PATH
