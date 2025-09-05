export XX_CACHE_DIR="${HOME}/.cache/xx"
xx() {
    __xx_get_functions | fzf --header-lines=1 \
        --info=inline \
        --ansi \
        --layout=reverse-list \
        --accept-nth 1 \
        --border-label " xx " \
        --color 'border:#f4e0dc,label:#f4e0dc,header:#f4e0dc:bold,preview-fg:#f4e0dc' \
        --preview="echo 'ENTER: Execute Command'" \
        --preview-window=down,1,border-none --tmux 80%
}
