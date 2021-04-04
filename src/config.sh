
function configureSsh() {
    running "Configuring ssh"
    mkdir -p ~/.ssh
    if [ ! -f ~/.ssh/config ]; then
        cp $dotfilesPath/config/ssh-config ~/.ssh/config
        echo "Installed SSH config file..."
    fi
    ok
}

function configureNode() {
    running "Configuring node/npm"

    if [ environment -eq "Darwin" ]; then
        #Remove any brew-installed NPM/Node instances
        #This is because node/npm are managed by NVM,
        #yet Yarn may install node/npm as depenencies
        #See: https://github.com/creationix/nvm/issues/855#issuecomment-370187398
        brew uninstall --ignore-dependencies --force node
        brew uninstall --ignore-dependencies --force npm
        brew cleanup
    fi

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
