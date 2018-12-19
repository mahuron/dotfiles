=========
File Load
=========

------------
zsh dotfiles
------------

From zsh(1) ::

  Commands are then read from $ZDOTDIR/.zshenv.  If the shell is a
  login shell, commands are read from /etc/zprofile and then
  $ZDOTDIR/.zprofile.  Then, if the shell is interactive, commands are
  read from /etc/zshrc and then $ZDOTDIR/.zshrc.  Finally, if the
  shell is a login shell, /etc/zlogin and $ZDOTDIR/.zlogin are read.

----------------
Config Fragments
----------------

In order to make fragment organization more intuitive, they have been
organized into directories which indicate their function:

env
  Sourced by .zshenv, these files are processed for all shell types.

login
  Sourced by .zprofile, these files are processed for login shells.

interactive
  Sourced by .zshrc, these files are processed for interactive shells.

--------------------
Fragment Directories
--------------------

Directories make use of canonical sysv init style loading.  Files are
processed in lexical order.  Only files which are executable (+x) will
be sourced.

