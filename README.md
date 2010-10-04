Patrick's dotfiles
===============

My UNIX dotfiles bared for the world to see. (Well they were originally Toby Tripp's, then Sudhindra Rao's, and now mine!)

Installation
------------

    git clone http://github.com/pturley/dotfiles.git dotfiles
    cd dotfiles
    ruby install.rb

alternatively:

    bash < <( curl http://github.com/pturley/dotfiles/raw/master/local-install.sh )


Remote Server Installation
--------------------------

The repository contains a script for setting up some bare-bones
dotfiles on remote servers.  These files include things like screen
configuration, a simple bashrc, and the sort.

Install with:
    bash < <( curl http://github.com/pturley/dotfiles/raw/master/remote-install.sh )

This just clones or updates the repository and links back bashrc and screenrc.

