_fzf_complete_man(){
    local lbuf="$1"
    local prefix="$2"
    local name section dash description
    local matches=($(man -k . | fzf -m | while read -r name section dash description; do
        echo "$name.${${section#\(}%\)}"
    done))
    [ -z "$matches" ] && return 1
    echo $LBUFFER
    LBUFFER="man ${matches[@]}"
}
