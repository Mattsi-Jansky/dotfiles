#!/usr/bin/env bash

configureSnapAliases() {
  sudo snap alias dotnet-sdk.dotnet dotnet
}

configureShell() {
  action "Configuring shell"

  #Change default shell. Annoyingly, this will ask for password. Doesn't work with sudo.
  running "Change default shell"
  if [ "$SHELL" = "/usr/bin/zsh" ]; then
    ok "Already set"
  else 
    chsh -s $(which zsh)
    ok
  fi

  #Powerlevel10K
  running "Install PL10K"
  tryGitClone romkatv powerlevel10k $dotfilesPath/powerlevel10k

  #Autosuggestions
  silently mkdir -p ~/.zsh/
  running "Install autosuggestions"
  tryGitClone zsh-users zsh-autosuggestions ~/.zsh/zsh-autosuggestions

  ok
}
