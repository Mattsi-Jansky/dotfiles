#!/usr/bin/env bash

dotfilesPath="/Users/$USER/.dotfiles"
libpath="$dotfilesPath/src"

#Script dependencies
source "$libpath/common.sh"
loadDependencies

#Install apps
requireHomebrew
requireBrewfileDependencies
requireNvm #Doesn't support homebrew so we do it differently

#Install shell & terminal emulator extensions
requireOhMyZsh
requireShellTheme
requireTerminalTheme

#Apply config settings
configure
configureTerminalAndShell
configureSecurity
configureSsh
configureNode
configureGitLfs

#Link dotfiles
createSymlinks

#fin
cleanup
ok "Complete."
