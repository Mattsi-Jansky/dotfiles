#!/usr/bin/env bash

requireNvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
}

requireSdkMan() {
    running "Installing SDKMAN"
    silently curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    ok

    running "Configuring SDKMAN"
    configFilePath="$HOME/.sdkman/etc/config"
    dotfilePath="$dotfilesPath/config/SdkMan/config"
    silently unlink $configFilePath
    silently ln -s $dotfilePath $configFilePath
    ok
}

requireJavaVersions() {
    running "Installing Java SDKMAN Plugin"
    silently sdk install java
    ok

    running "Install Java versions"

    action "Installing Java 8"
    silently sdk install java 8.0.265-zulu

    action "Installing Java 11"
    silently sdk install java 11.0.8-zulu

    action "Installing Java 14"
    silently sdk install java 14.0.2-zulu

    ok
}

requireRustVersions() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

