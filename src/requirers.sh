#!/usr/bin/env bash

requireNvm() {
    action "Installing nvm"

    running "Run remote install script"
    try curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh \| bash
}

requireSdkMan() {
    action "Installing SDKMAN"

    running "Run remote install script"
    try curl -s "https://get.sdkman.io" \| bash
    running "Init new install"
    try source "$HOME/.sdkman/bin/sdkman-init.sh"

    running "Linking config"
    configFilePath="$HOME/.sdkman/etc/config"
    dotfilePath="$dotfilesPath/config/SdkMan/config"
    silently unlink $configFilePath
    try ln -s $dotfilePath $configFilePath
}

requireJavaVersions() {
    action "Installing Java versions"

    running "Installing Java SDKMAN Plugin"
    try sdk install java

    running "Installing Java 8"
    try sdk install java 8.0.265-zulu

    running "Installing Java 11"
    try sdk install java 11.0.8-zulu

    running "Installing Java 14"
    try sdk install java 14.0.2-zulu

    ok
}

requireRust() {
    action "Installing Rust"

    running "Install remote script"
    if cargo -v &> /dev/null; then
        ok "Already installed"
    else
        try curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    fi

    ok
}

