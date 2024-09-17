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
  (brew list | grep -q "^$1$" >/dev/null && gecho "$1 found...") ||
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
command -v brew >/dev/null || recho "Homebrew not found, install before proceeding."

# Make sure zsh is installed
command -v zsh >/dev/null || recho "zsh not found, install before proceeding."

# Make sure curl is installed
command -v curl >/dev/null || recho "curl not found, install before proceeding."

FONT="font-jetbrains-mono-nerd-font"
install_brew $FONT

# Install Homebrew main programs
BREW_PROGRAMS="bat fd fzf gcc git git-delta lazygit neovim pngpaste ripgrep tmux zoxide"

for program in $BREW_PROGRAMS; do
  install_brew "$program"
done

# Install oh-my-zsh if not installed
if [[ ! -d ~/.oh-my-zsh ]]; then
  yecho "oh-my-zsh not found, installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
  yecho "powerlevel10k not found, installing..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install nvm (and node)
if [[ ! -d ~/.nvm ]]; then
  yecho "nvm not found, installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  unalias nvm node npm yarn && unset nvm_cmds && . ~/.nvm/nvm.sh --no-use && load-nvmrc && nvm
  nvm install node
fi

# Install tpm for tmux
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  yecho "tmux plugin manager not found, installing..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source-file ~/.tmux.conf
fi

HOME_FILES=".fdignore .gitconfig .ideavimrc .p10k.zsh .tmux.conf .scripts .zsh .zshrc"

for file in $HOME_FILES; do
  linkdotfile "$file" "$HOME/$file"
done

linkdotfile .config/alacritty ~/.config/alacritty
linkdotfile .config/git ~/.config/git
linkdotfile .obsidian ~/.config/obsidian
linkdotfile karabiner.json ~/.config/karabiner/karabiner.json
linkdotfile .lazygit-config.yml "$HOME/Library/Application Support/lazygit/config.yml"
