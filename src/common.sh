function authenticateSudo() {
    sudo -v
}

function loadDependencies() {
    source "$libpath/echos.sh"
    source "$libpath/requirers.sh"
    source "$libpath/config.sh"
}

function run() {
    action $1
    $1
}

function silently() {
    $* > /dev/null 2>&1
}

function createSymlinks() {
    action "Linking dotfiles"
    silently pushd $dotfilesPath/homedir
        for file in .*; do
            if [[ $file == "." || $file == ".." ]]; then continue; fi
            running "~/$file"
            createSymLink $file
            echo -en '\tlinked'
            ok
        done
    silently popd
    ok "dotfiles linked"
}

function createSymLink() {
    file="$1"
    silently unlink ~/$file
    ln -s $dotfilesPath/homedir/$file ~/$file
}

cleanup() {
    silently brew cleanup
}