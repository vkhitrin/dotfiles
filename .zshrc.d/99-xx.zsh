if [[ $(uname) == "Darwin" ]]; then
    export XX_CLIPBOARD_COMMAND="pbcopy"
    export XX_OPEN_COMMAND="open --background"
    export XX_GNU_AWK_COMMAND="gawk"
    export XX_GNU_SED_COMMAND="gsed"
elif [[ $(uname) == "Linux" ]]; then
    export XX_CLIPBOARD_COMMAND="wl-copy"
    export XX_OPEN_COMMAND="xdg-open"
    export XX_GNU_AWK_COMMAND="awk"
    export XX_GNU_SED_COMMAND="sed"
fi

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
