#!/usr/bin/env bash

requireAptGetDependencies() {
    sudo apt update
    xargs -a $linuxDotfilesPath/aptfile sudo apt-get install -y 
}

requireSnapDependencies() {
    snap slack
    snap exercism
    snapClassic code
    snapClassic dotnet-sdk
    snapClassic powershell
    sudo snap refresh
}

snap() {
    sudo snap install $1
}

snapClassic() {
    sudo snap install --classic $1
}

requireAlacritty() {
    pushd $linuxDotfilesPath
        git clone https://github.com/alacritty/alacritty.git
        pushd ./alacritty
            #Build
            echo "HELLO"
            echo "$HOME"
            source "$HOME/.cargo/env"
            cargo build --release --offline
            #Install terminfo
            sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
            #Copy binaries, reset desktop info
            sudo cp target/release/alacritty /usr/local/bin
            sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
            sudo desktop-file-install extra/linux/Alacritty.desktop
            sudo update-desktop-database
            #Install manpage
            sudo mkdir -p /usr/local/share/man/man1
            zip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
        popd
    popd
    #Link config
    silently mkdir -p ~/.config/alacritty
    silently unlink ~/.config/alacritty/alacritty.yml
    ln -s $dotfilesPath/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
}

cargo() {
    sudo cargo install $1
}
