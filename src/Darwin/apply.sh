#!/usr/bin/env bash

macDotfilesPath=$libpath/Darwin

#Script dependencies
source "$libpath/echos.sh"
source "$libpath/common.sh"
source "$macDotfilesPath/config.sh"
source "$macDotfilesPath/requirers.sh"

#Install dependencies
requireHomebrew
requireBrewfileDependencies

#Install shell & terminal emulator extensions
requireOhMyZsh
requireShellTheme
requireTerminalTheme

#Apply config settings
configure
configureTerminalAndShell
configureSecurity
