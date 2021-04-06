# Add bashrc settings
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi


#Fortune prompt
fortune | randomsay | lolcat

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.dotfiles/powerlevel10k/powerlevel10k.zsh-theme

#SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "/Users/mattsi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mattsi/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Include Autojump
[[ ! -f "/usr/share/autojump/autojump.sh" ]] || source /usr/share/autojump/autojump.sh

# cd shortcuts
setopt auto_cd  autocd autopushd \ pushdignoredups
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
