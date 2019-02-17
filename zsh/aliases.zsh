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
fi

alias la="ls -A"
alias ll="ls -lh"
alias lla='ls -lAh'
alias less='less -r'
