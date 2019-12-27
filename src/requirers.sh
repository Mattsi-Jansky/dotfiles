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

requireHomebrewCask() {
    running "checking Homebrew Cask install"
    output=$(brew tap | grep cask)
    if [[ $? != 0 ]]; then
        action "installing brew-cask"
        run "brew install caskroom/cask/brew-cask"
        if [[ $? != 0 ]]; then
            error "failed to install Homebrew Cask! aborting..."
            exit 2
        fi
    fi
    brew tap caskroom/versions > /dev/null 2>&1
    ok
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
}
