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