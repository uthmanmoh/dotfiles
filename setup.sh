#!/bin/bash
set -e
set -u

RCol='\033[0m'   # Reset Color (Default)
Gre='\033[0;32m' # Green
Red='\033[0;31m' # Red
Yel='\033[0;33m' # Yellow

## printing functions ##
function gecho {
  echo -e "${Gre}[message] $1${RCol}"
}

function yecho {
  echo -e "${Yel}[warning] $1${RCol}"
}

function wecho {
  # red, but don't exit 1
  echo -e "${Red}[error] $1${RCol}"
}

function recho {
  echo -e "${Red}[error] $1${RCol}"
  exit 1
}

## install functions ##

# If program is not installed using brew, run brew install on it
function install_brew {
  (brew list | grep -q $1 >/dev/null && gecho "$1 found...") ||
    (yecho "$1 not found, installing via homebrew..." && brew install $1)
}

# function for linking dotfiles
function linkdotfile {
  file="$1"
  ln_path="$2"
  directory=$(dirname "$ln_path")

  if [ ! -d "$directory" ]; then
    wecho "$directory not found, creating..."
    mkdir -p "$directory"
  fi

  if [ ! -e "$ln_path" ]; then
    yecho "linking ~/dotfiles/$file -> $ln_path" >&2
    ln -s ~/dotfiles/"$file" "$ln_path"
  else
    gecho "$ln_path already found, ignoring..." >&2
  fi
}

# Make sure homebrew is installed
[[ ! $(command -v brew >/dev/null) ]] ||
  recho "Homebrew not found, install before proceeding."

# install Homebrew main programs
BREW_PROGRAMS=("bat" "fd" "fzf" "gcc" "git" "lazygit" "neovim" "pngpaste" "ripgrep" "tmux" "zoxide")

for program in ${BREW_PROGRAMS[@]}; do
  install_brew $program
done

HOME_FILES=(".fdignore" ".gitconfig" ".ideavimrc" ".p10k.zsh" ".tmux.conf" ".scripts" ".zsh" ".zshrc")

for file in "${HOME_FILES[@]}"; do
  linkdotfile "$file" "$HOME/$file"
done

linkdotfile .config/alacritty ~/.config/alacritty
linkdotfile .config/git ~/.config/git
linkdotfile .lazygit-config.yml "$HOME/Library/Application Support/lazygit/config.yml"
linkdotfile .obsidian "$HOME/.config/obsidian"
linkdotfile karabiner.json ~/.config/karabiner/karabiner.json
