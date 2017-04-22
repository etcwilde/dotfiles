HISTFILE=~/.config/zsh/zsh_histfile
HISTSIZE=1024
setopt append_history           # Don't overwrite
setopt share_history            # Read commands from multiple shells
setopt extended_history         # Timestamps
setopt histignorealldups
setopt histignorespace          # Ingnore leading and trailing spaces
