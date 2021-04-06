#!/usr/bin/env bash

requireAptGetDependencies() {
    action "Installing apt-get dependencies"

    running "Update apt"
    try sudo apt update
    running "Install packages"
    try xargs -a $linuxDotfilesPath/aptfile sudo apt-get install -y 

    ok
}

requireSnapDependencies() {
    action "Installing Snap dependencies"

    snap slack
    snap exercism
    snapClassic code
    snapClassic dotnet-sdk
    snapClassic powershell
    running "Update snaps"
    try sudo snap refresh

    ok
}

snap() {
    running "$1"
    try sudo snap install $1
}

snapClassic() {
    running "$1"
    try sudo snap install --classic $1
}

requireFonts() {
    action "Installing Linux fonts"

    running "Ensure directories exist"
    try mkdir -p ~/.fonts
    running "Ensure directories exist"
    try mkdir -p ~/.config/fontconfig/conf.d/
    running "Copy font files"
    try cp "$dotfilesPath/config/fonts/Ubuntu\ Mono\ derivative\ Powerline.ttf" ~/.fonts
    running "Copy font files"
    try cp $dotfilesPath/config/fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    running "Reset font cache"
    try sudo fc-cache

    ok
}

requireAlacritty() {
    action "Installing Alacritty"

    silently pushd $linuxDotfilesPath
        running "Clone repository"
        if [ -d "./alacritty" ]; then
            ok "already exists"
        else
            try git clone https://github.com/alacritty/alacritty.git
        fi
        silently pushd ./alacritty
            running "Building binary"
            if [ -f "target/release/alacritty" ]; then
                ok "already exists"
            else
                try cargo build --release --offline
            fi

            #Install terminfo
            sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

            running "Copying binary"
            if [ -f "/usr/local/bin/alacritty" ]; then
                ok "already exists"
            else
                sudo cp target/release/alacritty /usr/local/bin
                sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
                sudo desktop-file-install extra/linux/Alacritty.desktop
                sudo update-desktop-database
            fi

            running "Add desktop entry"
            try sudo desktop-file-install extra/linux/Alacritty.desktop
            running "Resetting desktop database"
            try sudo update-desktop-database

            #Install manpage
            sudo mkdir -p /usr/local/share/man/man1
            zip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
        silently popd
    silently popd
    running "Linking config"
    try mkdir -p ~/.config/alacritty
    running "Linking config"
    silently unlink ~/.config/alacritty/alacritty.yml
    try ln -s $dotfilesPath/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

    ok
}

requireCargoDependencies() {
    action "Installing Cargo dependencies"

    cargoInstall git-delta

    ok "Cargo dependencies installed"
}

cargoInstall() {
    running "$1"
    cargo install $1
}
