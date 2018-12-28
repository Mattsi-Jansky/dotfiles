Prerequisites
=============

macOS. Installs Brew and all other dependencies automatically.

Setup
=====

 * `git clone git@github.com:Mattsi-Jansky/dotfiles.git ~/.dotfiles`
 * `~/.dotfiles/init.sh`

 Run `refresh-dotfiles` to update configuration changes after the first install. This calls a separate script, `update.sh`. Update is re-entrant and idempotent; install nearly is except for iTerm complaining about duplicate colour schemes, so it's best to use refresh-dotfiles after the initial setup.

Acknowledgents
==============

 * Adam Eivy, several of the bash files are hacked together from bits of his dotfiles.
 * Nick Charlton and thoughtbot, I learned about Brewfiles and a few other bits by reading their dotfiles.
