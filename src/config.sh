
function configureSsh() {
    action "Configuring ssh"

    running "Ensure ssh folder exists"
    try mkdir -p ~/.ssh

    running "Copying SSH config"
    if [ -f ~/.ssh/config ]; then
        ok "Already exists"
    else
        try cp $dotfilesPath/config/ssh-config ~/.ssh/config
        echo "Installed SSH config file..."
    fi

    ok
}

function configureNode() {
    action "Configuring node/npm"

    if [ "$environment" -eq "Darwin" ]; then
        #Remove any brew-installed NPM/Node instances
        #This is because node/npm are managed by NVM,
        #yet Yarn may install node/npm as depenencies
        #See: https://github.com/creationix/nvm/issues/855#issuecomment-370187398
        run "Uninstall brew node"
        try brew uninstall --ignore-dependencies --force node
        run "Uninstall brew node"
        try brew uninstall --ignore-dependencies --force npm
        run "Cleanup brew"
        try brew cleanup
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    running "Ensure latest node installed"
    try nvm install node
    running "Ensure latest node installed"
    try nvm use node

    running "Always pin dependency versions"
    try npm config set save-exact true

    ok
}

function configureGitLfs() {
    action "Configure Git LFS"
    try git lfs install
    ok
}
