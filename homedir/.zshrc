#ZSH config
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

#P9K configuration
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
#source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="robbyrussell"

#oh-my-zsh plugins
plugins=(
    osx
    history)

# Add bashrc settings
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

#Include oh-my-zsh
source $ZSH/oh-my-zsh.sh

#iTerm2 Shell Integration
source ~/.iterm2_shell_integration.zsh

#Fortune prompt
fortune | randomsay | lolcat

#iTerm2 tab titles
function chpwd(){ echo -ne "\033]0;${PWD##/*/}\007" }
