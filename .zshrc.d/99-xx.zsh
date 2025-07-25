export XX_CACHE_DIR="${HOME}/.cache/xx"
xx() {
    __xx_get_functions | fzf --header-lines=1 \
        --info=inline \
        --ansi \
        --layout=reverse-list \
        --accept-nth 1 \
        --border-label " xx " \
        --color 'border:#F4E0DC,label:#F4E0DC,header:#F4E0DC:bold,preview-fg:#F4E0DC' \
        --preview="echo 'ENTER: Execute Command'" \
        --preview-window=down,1,border-none --tmux 80%
}
