Toby's dotfiles
===============

My UNIX dotfiles bared for the world to see.

Installation
------------

    git clone http://github.com/tobytripp/dotfiles.git dotfiles
    cd dotfiles
    ruby install.rb


Remote Server Installation
--------------------------

The repository contains a script for setting up some bare-bones
dotfiles on remote servers.  These include things like screen
configuration, simple bashrc, and the sort.

Install with:
    bash < <( curl http://github.com/tobytripp/dotfiles/raw/master/remote-install.sh )

