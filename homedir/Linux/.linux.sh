alias python=python3
PATH="/root/.cargo/bin:$PATH"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alacrittyCompletions="~/.dotfiles/src/Linux/alacritty/extra/completions/alacritty.bash"
[[ -f "$alacrittyCompletions" ]] && source "$alacrittyCompletions"