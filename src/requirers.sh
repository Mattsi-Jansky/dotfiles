#!/usr/bin/env bash

requireHomebrew() {
    running "checking homebrew install"
    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        action "installing homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [[ $? != 0 ]]; then
            error "Failed to install Homebrew, script $0! abort.."
            exit 2
        else
            ok "Homebrew install completed"
        fi
    else
        ok "homebrew already installed"
        # Make sure we’re using the latest Homebrew
        running "updating homebrew"
        brew update
        # Upgrade any already-installed formulae
        action "upgrade brew packages..."
        brew upgrade
        ok "brews updated..."
    fi
}

requireBrewfileDependencies() {
    silently pushd $dotfilesPath
    brew bundle
    silently popd
}

requireOhMyZsh() {
    action "Installing OhMyZsh (if necessary)..."
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ok
}

requireShellTheme() {
    running "Installing Powerlevel9K Theme"
    if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
        echo "Powerlevel9K already installed."
    else
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    fi
    ok
}

requireTerminalTheme() {
    running "Installing the Solarized Light theme for iTerm"
    open "$dotfilesPath/config/iterm-styles/Solarized Light.itermcolors"
    ok

    running "Installing the Patched Solarized Dark theme for iTerm"
    open "$dotfilesPath/config/iterm-styles/Solarized Dark Patch.itermcolors"
    ok

    running "Installing Brogrammer theme for iTerm"
    open "$dotfilesPath/config/iterm-styles/Brogrammer.itermcolors"
    ok
}

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
    silently sdk install java 8.0.252-zulu

    action "Installing Java 11"
    silently sdk install java 11.0.7-zulu

    action "Installing Java 14"
    silently sdk install java 14.0.1-zulu

    ok
}
