#!/usr/bin/env bash

dotfilesPath="$HOME/.dotfiles"
libpath="$dotfilesPath/src"
linuxDotfilesPath="$libpath/Linux"

#Script dependencies
source "$linuxDotfilesPath/requirers.sh"
source "$linuxDotfilesPath/config.sh"
source "$libpath/echos.sh"
source "$libpath/common.sh"

#Install dependencies
requireAptGetDependencies
requireSnapDependencies
requireFonts
requireAlacritty

#Config
configureSnapAliases
configureShell
requireCargoDependencies