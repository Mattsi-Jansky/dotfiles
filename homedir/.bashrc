source ~/.aliases
source ~/.funcs

#Unique history for each ITERM session
export HISTFILE=~/.bash_sessions/.bash_history_${ITERM_SESSION_ID%:*}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm