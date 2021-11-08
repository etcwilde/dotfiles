if prog_exists 'fzf'; then
  [ -f $ZSH/fzf/completion.zsh ] && . $ZSH/fzf/completion.zsh
  [ -f $ZSH/fzf/mancomplete.zsh ] && . $ZSH/fzf/mancomplete.zsh
fi
