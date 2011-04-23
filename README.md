Sudhindra's dotfiles
===============

My UNIX dotfiles bared for the world to see. (Well they were originally Toby Tripp's, then Sudhindra Rao's, and now Patrick Turley)

Installation
------------

    git clone http://github.com/betarelease/dotfiles.git dotfiles
    cd dotfiles
    ruby install.rb

alternatively:

    bash < <( curl http://github.com/betarelease/dotfiles/raw/master/local-install.sh )

Uninstallation
------------

Now you can cleanly uninstall and reinstall your dotfiles.
  
  cd dotfiles
  
  ruby uninstall.rb
  
Remote Server Installation
--------------------------

The repository contains a script for setting up some bare-bones
dotfiles on remote servers.  These files include things like screen
configuration, a simple bashrc, and the sort.

Install with:
    bash < <( curl http://github.com/betarelease/dotfiles/raw/master/remote-install.sh )

This just clones or updates the repository and links back bashrc and screenrc.

