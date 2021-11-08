if prog_exists 'fzf'; then
  [ -f $ZSH/fzf/completion.zsh ] && . $ZSH/fzf/completion.zsh
fi
