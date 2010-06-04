#!/bin/sh

# A script to install some bare-bones dotfiles for use on remote servers.
# 
# Usage:
#  bash < <( curl http://github.com/tobytripp/dotfiles/raw/master/remote-install.sh )

git clone http://github.com/tobytripp/dotfiles.git .dotfiles
pushd .dotfiles

for dotfile in screenrc bashrc
do
    ln -s $dotfile ~/.$dotfile
done
