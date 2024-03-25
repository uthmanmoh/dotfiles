#!/bin/zsh -ex

cd ~/.local

if [ -d nvim-macos ]; then
  rm -rf nvim-macos
fi

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
xattr -c ./nvim-macos.tar.gz
tar xzvf nvim-macos.tar.gz
rm nvim-macos.tar.gz
