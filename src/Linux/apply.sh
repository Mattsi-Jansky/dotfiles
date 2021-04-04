#!/usr/bin/env bash

dotfilesPath="$HOME/.dotfiles"
libpath="$dotfilesPath/src"
linuxDotfilesPath="$libpath/Linux"

#Script dependencies
source "$linuxDotfilesPath/requirers.sh"
source "$linuxDotfilesPath/config.sh"

#Install dependencies
requireAptGetDependencies
requireSnapDependencies

#Config
configureSnapAliases
