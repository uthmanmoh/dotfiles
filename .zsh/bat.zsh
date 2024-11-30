export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Use bat as manpager
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain' # Use bat for -h help
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain' # ... or --help
alias -g -- --expand='--expand 2>&1 | bat --language=help --style=plain' # ... or --expand

export BAT_THEME="Catppuccin-macchiato"

alias cat='bat --style=plain' # Use bat as cat

