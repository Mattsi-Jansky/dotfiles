function authenticateSudo() {
    sudo -v
}

function loadDependencies() {
    source "$libpath/echos.sh"
    source "$libpath/vscode.sh"
    source "$libpath/config.sh"
    source "$libpath/requirers.sh"
}

function run() {
    action $1
    $1
}

function silently() {
    $* > /dev/null 2>&1
}

function try() {
    eval $* > /tmp/try.out 2>/tmp/try.error #Evaluate arguments, store result
    if [ "$?" = 0 ] ; then # If command succeeded
        ok
    else
        error "$(cat /tmp/try.out) $(cat /tmp/try.error)"
    fi
}

function createSymlinks() {
    action "Linking dotfiles"
    createSymlinksFor shared
    createSymlinksFor $environment
    ok "dotfiles linked"
}

function createSymlinksFor() {
    source="$1"
    action "Linking dotfiles"
    silently pushd $dotfilesPath/homedir/$1
        for file in .*; do
            if [[ $file == "." || $file == ".." || $file == ".git" ]]; then continue; fi
            running "~/$file"
            createSymLink $file $source
            echo -en '\tlinked'
            ok
        done
    silently popd
}

function createSymLink() {
    file="$1"
    source="$2"
    silently unlink ~/$file
    ln -s $dotfilesPath/homedir/$source/$file ~/$file
}