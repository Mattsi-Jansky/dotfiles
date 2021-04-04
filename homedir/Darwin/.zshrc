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
    history
    autojump)

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
function chpwd() {
	title=${PWD##/*/}
	if git rev-parse --git-dir > /dev/null 2>&1; then
		title=$(basename `git rev-parse --show-toplevel`)
	fi
	echo -ne "\033]0;${title}\007"
}

#SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "/Users/mattsi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mattsi/.sdkman/bin/sdkman-init.sh"
