# My Dotfiles

This is a collection of my dotfiles - configuration files for various tools and programs I use, such as `zsh`, `git`, etc.

I use a Mac with [iTerm2](https://iterm2.com/) and [oh-my-zsh](https://ohmyz.sh/), configured with the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme.

![Alacritty Setup](assets/AlacrittySetup.png)

You can find my neovim configuration here: [github.com/1239uth/nvim](https://github.com/1239uth/nvim)

## How I setup my Dotfiles

I use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles. It's a simple symlink manager that allows me to keep my dotfiles in a separate directory and symlink them into `$HOME` to behave like normal.

See this video for an explanation of how you can setup your dotfiles using `stow`: [https://youtu.be/y6XCebnB9gs](https://youtu.be/y6XCebnB9gs)

## Tools I use

```sh
# github.com/junegunn/fzf
brew install fzf # Fuzzy finder

# github.com/BurntSushi/ripgrep
brew install ripgrep # Faster grep

# github.com/sharkdp/fd
brew install fd # Faster find

# github.com/sharkdp/bat
brew install bat # Better cat with syntax highlighting (see bat.zsh for configurations)

# github.com/eza-community/eza
brew install eza # Better ls, specifically for the tree view

# github.com/ajeetdsouza/zoxide
brew install zoxide # A smarter cd command

# github.com/jesseduffield/lazygit
brew install lazygit # A simple terminal UI for git commands

# github.com/dandavison/delta
brew install git-delta # A better git diff (see gitconfig for configurations)

# github.com/neovim/neovim
brew install neovim # See my neovim configuration at github.com/1239uth/nvim

# github.com/tmux/tmux
brew install tmux # See my tmux configuration in .tmux.conf
```
