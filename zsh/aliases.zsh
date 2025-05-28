# Emacs aliases
alias e="emacsclient -t"
alias ec="emacsclient -c"
alias em="emacs -t"

# Basic Environment

if [[ $(uname) = 'Darwin' ]]; then
  alias ls="ls -G"
elif [[ $(uname) = 'Linux' ]]; then
  alias ls="ls --color=auto"
  alias open="xdg-open"
  # Watch with color
  alias watch="watch --color"
elif [[ $(uname) = 'FreeBSD' ]]; then
  alias ls="ls --color"
fi

alias la="ls -A"
alias ll="ls -lh"
alias lla='ls -lAh'
alias less='less -r'

if prog_exists 'fzf'; then
  alias pidsearch='ps -a | fzf | awk '\''{ print $1 }'\'''
  alias gbs='git branch-search'
  alias gcs='git commit-search'
else
  alias pidsearch='echo "install fzf"'
  alias gbs='echo "install fzf"'
  alias gcs='echo "install fzf"'
fi
