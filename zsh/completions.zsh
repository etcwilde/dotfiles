# completion
autoload -Uz compinit
compinit -d "${HOME}/.config/zsh/.${HOST}-zcompdump"

# caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.config/zsh/.${HOST}-zcompcache"

# colourise output
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# completion suggestion order
zstyle ':completion:*' completer _expand _complete _prefix _correct _match _approximate

# message formatting
zstyle ':completion:*:descriptions' format '%B%F{yellow} -- %d -- %f%b'
zstyle ':completion:*:messages' format '%B%F{blue} -- %d -- %f%b'
zstyle ':completion:*:warnings' format '%B%F{red} -- No Matches Found -- %f%b'

# grouping
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'

# ignored completion
# commands that are not present
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# prevent parameter resuggestion
zstyle ':completion:*:ls:*' ignore-line yes
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:scp:*' ignore-line yes
zstyle ':completion:*:diff:*' ignore-line yes

# jobs
zstyle ':completion:*:jobs' numbers true

# man pages
zstyle ':completion:*:manuals:*' insert-sections true
zstyle ':completion:*:manuals:*' separate-sections true

# matching
# case insensitive, partial matching, substitution
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[-._]=* r:|=*' 'l:|=* r:|=*' '+l:|=*'

# menu
zstyle ':completion:*' menu select

# completion options
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-descriptions 'yes'

# process management
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' command 'ps -U '${USERNAME}' -o pid,cmd | sed "/ps -U '${USERNAME}' -o pid,cmd/d"'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=31;31'

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' command 'ps -U '${USERNAME}' -o cmd'

zstyle ':completion:*:processes-names' command 'ps axho command'
