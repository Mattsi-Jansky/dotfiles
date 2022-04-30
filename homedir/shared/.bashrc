source ~/.aliases
source ~/.funcs

[[ -f "~/.darwin.sh" ]] && source "~/.darwin.sh"
[[ -f "~/.linux.sh" ]] && source "~/.linux.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Cargo binaries
export PATH=$PATH:$HOME/.cargo/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/mattsi/.sdkman"
[[ -s "/home/mattsi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/mattsi/.sdkman/bin/sdkman-init.sh"
