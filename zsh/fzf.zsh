if ! prog_exists fzf; then
  return 0
fi

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:gray,hl:yellow \
  --color=fg+:white,bg+:black,gutter:-1,hl+:red \
  --color=info:blue,header:blue,pointer:red \
  --color=border:black \
  --height=50%"
