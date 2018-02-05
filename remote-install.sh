#!/usr/bin/env bash

# A script to install some bare-bones dotfiles for use on remote servers.
#
# Usage:
#  bash < <( curl http://github.com/tobytripp/dotfiles/raw/master/remote-install.sh )

DOTFILE_PATH="${DOTFILE_PATH:-$HOME/.dotfiles}"

if [[ -d "$HOME/.dotfiles" ]]; then
    pushd $DOTFILE_PATH
    git pull origin master
else
    git clone http://github.com/tobytripp/dotfiles.git $DOTFILE_PATH
    pushd $DOTFILE_PATH
fi

for dotfile in screenrc bashrc zshrc
do
    ln -s $DOTFILE_PATH/$dotfile ~/.$dotfile
done

popd
