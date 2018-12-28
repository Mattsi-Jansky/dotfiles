#!/usr/bin/env bash

dotfilesPath="/Users/$USER/.dotfiles"
libpath="$dotfilesPath/src"

#Script dependencies
source "$libpath/common.sh"
loadDependencies

#Install apps
requireBrewfileDependencies

#Apply config settings
configure
configureTerminalAndShell
configureSecurity
configureSsh
configureNode

#Link dotfiles
createSymlinks

#fin
cleanup
ok "Complete."