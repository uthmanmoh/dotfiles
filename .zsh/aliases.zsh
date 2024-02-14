#### SCHOOL ALIASES
alias school="cd ~/Documents/SchoolWork/Year3Sem2"

alias mars="java -jar ~/Documents/SchoolWork/Year2Sem2/CSCB58/Mars4_5.jar"

alias start-vm='VBoxManage startvm "vm"'

### GENERAL
alias python="python3"
alias python2="~/.pyenv/versions/2.7.18/bin/python"
alias ls="ls -GF"
alias ll="ls -lArth"
alias lss="ls -lArSh" # ls sort by size
alias grep="grep --color=auto -i"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias tree="eza --tree --level=3 --icons --git --git-ignore -A --sort=modified"
alias vi="nvim"

alias jq="jaq"
alias sz="source ~/.zshrc"

alias battery="system_profiler SPPowerDataType | grep Cycle"

alias ai="gh copilot suggest -t shell"

eval "$(zoxide init --cmd cd zsh)"

export NEOVIM_CONFIG=~/.config/nvim

bindkey -M viins '^L' vi-forward-char # ctrl + l to replace right arrow key (useful in vi mode)

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

len() {
    local concatenated_string="$*"
    echo ${#concatenated_string}
}

term() {
  # if $1 passed in, open -a "iTerm" in that directory
  # else open -a "iTerm" in current directory
  if [ -z "$1" ]; then
    open -a "iTerm" .
  else
    open -a "iTerm" "$1"
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
