#!/usr/bin/env bash

export dotfilesPath="$HOME/.dotfiles"
export libpath="$dotfilesPath/src"
environment="$(uname)"

#Script dependencies
source "$libpath/common.sh"
loadDependencies

#Load platform-specific dependencies
$libpath/$environment/apply.sh

#Install cross-platform apps
requireNvm
requireSdkMan
requireJavaVersions
requireRust

#Apply config settings
configureSsh
configureNode
configureGitLfs
configureVisualStudioCode

#Link dotfiles
createSymlinks

#fin
ok "Complete."
