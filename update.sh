#!/usr/bin/env bash

dotfilesPath="$HOME/.dotfiles"
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
configureVisualStudioCode

#Link dotfiles
createSymlinks

#fin
cleanup
ok "Complete."
