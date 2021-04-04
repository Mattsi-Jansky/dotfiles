#!/usr/bin/env bash

function configureVisualStudioCode() {
    symLinkVsCodeConfig
    installVisualStudioCodeExtensions
}

function symLinkVsCodeConfig() {
    action "Symlinking VSCode config"

    symLinkVsCode settings.json
    symLinkVsCode keybindings.json

    ok "Done"
}

function symLinkVsCode() {
    dotfilePath="$dotfilesPath/config/VsCode/$environment/$1"
    if [ environment = "Darwin" ]; then
        configFilePath="$HOME/Library/Application Support/Code/User/$1"
    else
        configFilePath="$HOME/.config/Code/User/$1"
    fi

    silently unlink $configFilePath
    silently ln -s $dotfilePath $configFilePath
}

function installVisualStudioCodeExtensions() {
    action "Installing VSCode extensions"

    installVsCodeExtension ionide.ionide-fsharp
    installVsCodeExtension davidanson.vscode-markdownlint
    installVsCodeExtension ms-azuretools.vscode-docker
    installVsCodeExtension ms-vscode.csharp
    installVsCodeExtension eamodio.gitlens
    installVsCodeExtension vscode-icons-team.vscode-icons
    installVsCodeExtension mauve.terraform

    ok "VSCode extensions installed"
}

function installVsCodeExtension() {
    running "Installing VSCode extension $1"
    silently code --install-extension $1
    ok "Done"
}
