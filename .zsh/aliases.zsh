### GENERAL
alias python="python3"
alias python2="~/.pyenv/versions/2.7.18/bin/python"
alias ls="ls -GF" # enable colours and file type indicators
alias ll="ls -lArth" # ls with long format sorted by modified date
alias lss="ls -lArSh" # ls sort by size
alias grep="grep --color=auto -i" # case insensitive grep with colour

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias tree="eza --tree --level=3 --icons --git --git-ignore -A --sort=modified"

alias sz="source ~/.zshrc"
alias r="omz reload"

alias battery="system_profiler SPPowerDataType | grep Cycle"

alias ai="gh copilot suggest -t shell"

alias main="~/dotfiles/scripts/bin/main"

alias lg="lazygit"
alias g="git"
alias lzd="lazydocker"

# If nightly neovim is installed, use it, otherwise use default
if [ -f ~/.local/nvim-macos-x86_64/bin/nvim ]; then
  alias vi="~/.local/nvim-macos-x86_64/bin/nvim"
else
  alias vi="nvim"
fi

# alias cd to use zoxide github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

bindkey -r '^L' # Remove ctrl-l to clear history
bindkey -M viins '^L' vi-forward-char # ctrl + l to replace right arrow key (to accept autocomplete)

# Use fzf to find files from ~ and cd into the directory of the selected file
f() {
    local selection
    selection=$(cd && FZF_DEFAULT_COMMAND="fd --type f --type d" fzf --preview 'ls -1 {}' --preview-window=up:3:wrap)
    if [[ -n $selection ]]; then
        # Prepend the home directory path if the selection is not an absolute path
        [[ $selection != /* ]] && selection="$HOME/$selection"
        if [[ -d $selection ]]; then
            cd "$selection"
        else
            cd "$(dirname "$selection")"
        fi
    fi
}

# Remove all neovim swap files
swapclean() {
  SWAP_DIR=~/.local/state/nvim/swap
  echo "Removing swap files..."
  fd -I --type f --glob "*.swp" $SWAP_DIR -x sh -c 'echo {} && rm {}'
  echo "Done"
}
