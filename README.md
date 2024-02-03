# My Dotfiles

This is a collection of my dotfiles - configuration files for various tools and programs I use, such as `zsh`, `git`, etc.

I use a Mac with [iTerm2](https://iterm2.com/) and [oh-my-zsh](https://ohmyz.sh/), configured with the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme.

You can find my neovim configuration here: [github.com/1239uth/nvim](github.com/1239uth/nvim)

## How I setup my Dotfiles

I use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles. It's a simple symlink manager that allows me to keep my dotfiles in a separate directory and symlink them into `$HOME` to behave like normal.

See this video for an explanation of how you can setup your dotfiles using `stow`: [https://youtu.be/y6XCebnB9gs](https://youtu.be/y6XCebnB9gs)
