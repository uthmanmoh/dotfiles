export PS1="%F{green}•%f %B%F{240}%1~%f%b $ " # Custom prompt for regular terminal

# Homebrew paths first so they take precedence over system binaries (e.g. git)
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.scripts/bin:$PATH
export PATH=$HOME/go/bin:$PATH

export JAVA_PATH=$(/usr/libexec/java_home)
export JAVA_HOME=$JAVA_PATH

unsetopt share_history
setopt inc_append_history

[ -f ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh

# Set up mise for runtime management
eval "$(mise activate zsh)"

[ -f ~/.zsh/bat.zsh ] && source ~/.zsh/bat.zsh
[ -f ~/.zsh/bun.zsh ] && source ~/.zsh/bun.zsh
[ -f ~/.zsh/fzf.zsh ] && source ~/.zsh/fzf.zsh

# Poetry (Python)
fpath+=~/.zfunc
# autoload -Uz compinit && compinit

# Haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Setup homebrew
eval "$($(brew --prefix)/bin/brew shellenv)"
