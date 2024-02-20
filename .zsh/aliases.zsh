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
alias vi="nvim"
alias jq="jaq"

alias sz="source ~/.zshrc"
alias r="omz reload"

alias battery="system_profiler SPPowerDataType | grep Cycle"

alias ai="gh copilot suggest -t shell"

alias main="~/dotfiles/scripts/main.sh"

# alias cd to use zoxide github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

export NEOVIM_CONFIG=~/.config/nvim

bindkey -M viins '^L' vi-forward-char # ctrl + l to replace right arrow key (to accept autocomplete)

# Use fzf to find files from ~ and cd into the directory of the selected file
f() {
    local selection
    export FZF_DEFAULT_COMMAND="fd --type f --type d"
    selection=$(cd ~; fzf --preview 'ls -1 {}' --preview-window=up:3:wrap)
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

# Create a new obsidian "vault" by copying a base obsidian config
obsidian() {
  if [[ -d .obsidian ]]; then
    echo "Obsidian folder already exists"
    return 1
  fi
  cp -r ~/.config/obsidian/ ./.obsidian
  echo "Successfully copied obsidian config to .obsidian"
}
