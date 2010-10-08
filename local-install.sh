#!/usr/bin/env bash

# A script to install these dotfiles onto a new machine.
#
# Usage:
#  bash < <( curl http://github.com/pturley/dotfiles/raw/master/local-install.sh )

DOTFILE_PATH="${DOTFILE_PATH:-$HOME/.dotfiles}"

if [[ -d "$HOME/.dotfiles" ]]; then
    pushd $DOTFILE_PATH
    git pull origin master
else
    git clone http://github.com/betarelease/dotfiles.git $DOTFILE_PATH
    pushd $DOTFILE_PATH
fi

/usr/bin/env ruby install.rb
