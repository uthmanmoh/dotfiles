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

alias sz="source ~/.zshrc"

alias tree="eza --tree --level=3 --icons --git --git-ignore -A --sort=modified"

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

alias battery="system_profiler SPPowerDataType | grep Cycle"

len() {
    local concatenated_string="$*"
    echo ${#concatenated_string}
}

vi() {
  nvim "$@"
  echo -ne "\e[5 q" # change cursor back to vertical after exiting nvim since it will be in insert mode
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

export NEOVIM_CONFIG=~/.config/nvim

alias jq="jaq"

# for lazygit
if [[ -n $NVIM_LISTEN_ADDRESS ]]; then
  alias nvim="nvr -cc split --remote-wait +'set bufhidden=delete'"
fi

if [[ -n $NVIM_LISTEN_ADDRESS ]]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=delete'"
  export EDITOR="nvr -cc split --remote-wait +'set bufhidden=delete'"
else
  export VISUAL="nvim"
  export EDITOR="nvim"
fi

obsidian() {
  # check if .obsidian exists
  if [[ -d .obsidian ]]; then
    echo "Obsidian folder already exists"
    return 1
  fi
  cp -r ~/.config/obsidian/ ./.obsidian
  echo "Successfully copied obsidian config to .obsidian"
}

# ctrl + l to replace right arrow key
# bindkey '^L' vi-forward-char        # for vi-mode
bindkey -M viins '^L' vi-forward-char # for zsh-vi-mode

bindkey -v '^?' backward-delete-char # use vim keybindings in zsh

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ ${KEYMAP} == viopp ]]; then
    echo -ne '\e[1 q'  # Block cursor for normal mode
  else
    echo -ne '\e[5 q'  # Beam cursor for insert mode
  fi
}
zle -N zle-keymap-select

# This ensures the cursor shape is updated immediately after a command is run.
function zshreset {
  zle && zle .reset-prompt
}
precmd_functions+=('zshreset')

# Ensure cursor shape is correct when shell starts
echo -ne '\e[5 q'  # Beam cursor

# Reset cursor to block shape on exit
function zshexit {
  echo -ne '\e[1 q'
}
