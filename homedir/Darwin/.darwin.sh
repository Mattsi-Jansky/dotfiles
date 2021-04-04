#Unique history for each ITERM session
export HISTFILE=~/.bash_sessions/.bash_history_${ITERM_SESSION_ID%:*}
