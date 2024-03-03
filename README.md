# My Dotfiles

This is a collection of my dotfiles - configuration files for various tools and programs I use, such as `zsh`, `git`, etc.

My terminal setup includes:
- [Alacritty](https://alacritty.org) as my terminal emulator
- [Neovim](https://neovim.io) as my IDE (see my neovim configuration at [github.com/uthmanmoh/nvim](https://github.com/uthmanmoh/nvim))
- [oh-my-zsh](https://ohmyz.sh/) as my shell
- [Tmux](https://github.com/tmux/tmux) as my terminal session manager
- [Catppuccin](https://github.com/catppuccin) as my color scheme for Alacritty, Tmux, and Neovim
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) as my zsh theme

Here is a preview of my terminal setup:
![Alacritty Setup](assets/AlacrittySetup.png)

## How I setup my Dotfiles

I use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles. It's a simple symlink manager that allows me to keep my dotfiles in a separate directory and symlink them into `$HOME` to behave like normal.

See this video for an explanation of how you can setup your dotfiles using `stow`: [https://youtu.be/y6XCebnB9gs](https://youtu.be/y6XCebnB9gs)

## Additional CLI Tools I use

Note: You can install all of these tools using `brew` on macOS:

- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Faster `grep`
- [fd](https://github.com/sharkdp/fd) - Faster `find`
- [bat](https://github.com/sharkdp/bat) - Better `cat` with syntax highlighting
- [eza](https://github.com/eza-community/eza) - Better `ls,` specifically for the tree view
- [zoxide](https://github.com/ajeetdsouza/zoxide) - A smarter `cd` command
- [lazygit](https://github.com/jesseduffield/lazygit) - A simple terminal UI for git commands
- [delta](https://github.com/dandavison/delta) - A better git diff (see my `.gitconfig` for how I use it)

### Note on Obsidian
I use [Obsidian](https://obsidian.md) for note-taking. My global obsidian configuration is in the `.obsidian` directory.

You can download my obsidian configuration from this url: [https://downgit.evecalm.com/#/home?url=https://github.com/uthmanmoh/dotfiles/tree/main/.dotfiles](https://downgit.evecalm.com/#/home?url=https://github.com/uthmanmoh/dotfiles/tree/main/.dotfiles)
