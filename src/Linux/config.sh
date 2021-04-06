#!/usr/bin/env bash

configureSnapAliases() {
  sudo snap alias dotnet-sdk.dotnet dotnet
}

configureShell() {
  action "Configuring shell"

  #Change default shell. Annoyingly, this will ask for password. Doesn't work with sudo.
  chsh -s $(which zsh)

  #Powerlevel10K
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $dotfilesPath/powerlevel10k

  #Autosuggestions
  mkdir -p ~/.zsh/
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

  ok
}
