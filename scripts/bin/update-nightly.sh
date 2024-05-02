#!/bin/zsh -ex

cd ~/.local

if [ -d nvim-macos ]; then
  rm -rf nvim-macos
fi

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz
xattr -c ./nvim-macos-x86_64.tar.gz
tar xzvf nvim-macos-x86_64.tar.gz
rm nvim-macos-x86_64.tar.gz
