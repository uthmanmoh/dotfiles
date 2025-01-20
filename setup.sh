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

function is_mac() {
  [[ "$(uname)" == "Darwin" ]]
}

## install functions ##

# If program is not installed using brew, run brew install on it
function install_brew {
  local package_name="$1"
  local short_name="${package_name##*/}"

  if brew list | grep -q "^${short_name}$" >/dev/null; then
    gecho "$package_name is already installed"
  else
    yecho "$package_name not found, installing via homebrew..."
    brew install "$package_name"
  fi
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

# Install Homebrew main programs
BREW_PROGRAMS="bat fd fzf gcc git git-delta joshmedeski/sesh/sesh jesseduffield/lazydocker/lazydocker jesseduffield/lazygit/lazygit mise neovim ripgrep tldr tmux zoxide"
if is_mac; then
  # MacOS only
  BREW_PROGRAMS+=" pngpaste silicon font-jetbrains-mono-nerd-font"
  # Search font using `brew search font-` and from https://www.nerdfonts.com/font-downloads
fi

for program in $BREW_PROGRAMS; do
  install_brew "$program"
done

# Setup Bat theme (using variable in .zsh/bat.sh)
bat cache --build

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

# Install zsh-autosuggestions
if [[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
  yecho "zsh-autosuggestions not found, installing..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting
if [[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
  yecho "zsh-syntax-highlighting not found, installing..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install zsh-vi-mode
if [[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-vi-mode" ]]; then
  yecho "zsh-vi-mode not found, installing..."
  git clone https://github.com/jeffreytse/zsh-vi-mode \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
fi

# Install node
mise use -g node@lts

HOME_FILES=".fdignore .gitconfig .ideavimrc .p10k.zsh .tmux.conf .tmux.conf.local .scripts .zsh .zshrc"

for file in $HOME_FILES; do
  linkdotfile "$file" "$HOME/$file"
done

linkdotfile .config/alacritty ~/.config/alacritty
linkdotfile .config/git ~/.config/git
linkdotfile .config/bat ~/.config/bat
linkdotfile .config/sesh ~/.config/sesh
linkdotfile .obsidian ~/.config/obsidian
linkdotfile karabiner.json ~/.config/karabiner/karabiner.json
linkdotfile .scripts/shorten_path.sh ~/.tmux/scripts/shorten_path.sh
linkdotfile .lazygit-config.yml "$(lazygit -cd)/config.yml"
linkdotfile .config/lazydocker ~/.config/lazydocker

# Install tpm for tmux
#  need to do this after linking the dotfiles since tmux.conf depends on location
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  yecho "tmux plugin manager not found, installing..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source-file ~/.tmux.conf
fi
