export PS1="%F{green}•%f %B%F{240}%1~%f%b $ " # Custom prompt for regular terminal

export PATH=/usr/local/bin:$PATH # Specifically need to set this path before $PATH so homebrew takes precedence over system binaries (e.g. git)
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=/usr/local/opt/ruby/bin:$PATH # Homebrew Ruby before system Ruby
export PATH=$PATH:$HOME/.scripts/bin
export PATH=$PATH:$HOME/go/bin # Go path

export JAVA_PATH=$(/usr/libexec/java_home)
export JAVA_HOME=$JAVA_PATH

unsetopt share_history
setopt inc_append_history

[ -f ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh
[ -f ~/.zsh/amazon.zsh ] && source ~/.zsh/amazon.zsh

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
