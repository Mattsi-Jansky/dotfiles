function configure() {
    action "Updating config"

    #
    # Misc
    # 

    running "Enables saving iTerm state after closing app"
    defaults write "Apple Global Domain" NSQuitAlwaysKeepsWindows -bool yes
    ok

    running "Always show scrollbars"
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
    ok

    running "Expand save panel by default"
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    ok

    running "Expand print panel by default"
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    ok

    running "Save to disk (not to iCloud) by default"
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    ok

    running "Automatically quit printer app once the print jobs complete"
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
    ok

    running "Disable the “Are you sure you want to open this application?” dialog"
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    ok

    running "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)"
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
    ok

    running "Display ASCII control characters using caret notation in standard text views"
    # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
    defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
    ok

    running "Check for software updates daily, not just once per week"
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
    ok

    running "Disable smart quotes as they’re annoying when typing code"
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    ok

    running "Disable smart dashes as they’re annoying when typing code"
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    ok

    running "Require password immediately after sleep or screen saver begins"
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    ok

    #
    # Finder
    #

    running "Configuring Finder"
    # Show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    #Show status bar
    defaults write com.apple.finder ShowStatusBar -bool true
    #Show path barß
    defaults write com.apple.finder ShowPathbar -bool true
    #Allow text selection in Quick Look
    defaults write com.apple.finder QLEnableTextSelection -bool true
    #Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    #When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    #Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    ok

    #
    # Dock and Dashboard
    #

    running "Configuring Dock"
    #Size
    defaults write com.apple.dock tilesize -int 32
    #Magnification
    defaults write com.apple.dock largesize -int 48
    defaults write com.apple.systempreferences "NSWindow Frame Main Window Frame SystemPreferencesApp 8.0" -string "193 175 668 560 0 0 1440 877 "
    defaults write com.apple.dock magnification -bool yes
    #Orientation
    defaults write com.apple.dock magnification -bool yes
    defaults write com.apple.dock "show-process-indicators" -bool no
    #Only show running apps (no shortcuts)
    defaults write com.apple.dock static-only -bool true
    #Change minimize/maximize window effect to scale
    defaults write com.apple.dock mineffect -string "scale"
    #Hide Dock
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 1000
    defaults write com.apple.dock no-bouncing -bool TRUE
    ok

    running "Disabling dashboard"
    defaults write com.apple.dashboard mcx-disabled -bool true
    #Don’t show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true
    #Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false
    ok

    killDockAndWaitForItToRestart

    #
    # Mission Control
    #

    running "Configure Mission Control"
    #Speed up Mission Control animations
    defaults write com.apple.dock expose-animation-duration -float 0.1
    #Don’t group windows by application in Mission Control
    defaults write com.apple.dock expose-group-by-app -bool false
    ok

    ok "Config updated."
}

function configureTerminalAndShell() {
    action "Configuring terminal and shell"
    authenticateSudo

    # iTerm 2 preferences
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dotfilesPath/config/iterm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    #iTerm integration
    curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
    #Update default shell
    sudo chsh -s $(which zsh)

    ok "Terminal and shell configured."
}

function configureSecurity() {
    action "Configuring macOS security"
    authenticateSudo

    # Enable firewall. Possible values:
    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
    # Enable firewall stealth mode (no response to ICMP / ping requests)
    sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
    # Disable IR remote control
    sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false
    # Disable remote apple events
    sudo systemsetup -setremoteappleevents off
    # Disable remote login
    sudo systemsetup -setremotelogin off
    # Disable wake-on modem
    sudo systemsetup -setwakeonmodem off
    # Disable wake-on LAN
    sudo systemsetup -setwakeonnetworkaccess off
    # Disable guest account login
    sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

    ok "Security config applied."
}

function killDockAndWaitForItToRestart() {
    running "Restarting Dock to apply changes"
    killall Dock
    until pids=$(ps -A | grep -m1 Dock)
    do   
        sleep 1
    done
    echo "done."
}

function configureSsh() {
    running "Configuring ssh"
    mkdir -p ~/.ssh
    if [ ! -f ~/.ssh/config ]; then
        cp config/ssh-config ~/.ssh/config
        echo "Installed SSH config file..."
    fi
    ok
}

function configureNode() {
    running "Configuring node/npm"

    #Remove any brew-installed NPM/Node instances
    #This is because node/npm are managed by NVM,
    #yet Yarn may install node/npm as depenencies
    #See: https://github.com/creationix/nvm/issues/855#issuecomment-370187398
    brew uninstall --ignore-dependencies --force node
    brew uninstall --ignore-dependencies --force npm
    brew cleanup

    #Ensure latest node installed in NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install node
    nvm use node

    # always pin versions (no surprises, consistent dev/build machines)
    npm config set save-exact true

    ok
}

function configureGitLfs() {
    git lfs install
}

function configureVisualStudioCode() {
    running "Configuring VSCode"

    ln -s "$dotfilesPath/config/VSCode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
    ln -s "$dotfilesPath/config/VSCode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

    ok
}
