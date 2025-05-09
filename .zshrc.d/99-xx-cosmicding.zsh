[[ -n "${COSMICDING_SQLITE_DATABASE}" ]] || return

function bkmx() {
    # xx ;linkding:View bookmarks@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_cosmicding_bookmarks | fzf --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_cosmicding_bookmarks;__xx_get_cosmicding_bookmarks)' --prompt="Filter " \
        --bind="ctrl-u:become(echo {} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Bookmarks ' --color 'border:#b4befe,label:#b4befe,header:#b4befe:bold,preview-fg:#b4befe' \
        --preview="echo 'Ctrl-R: Refresh | Ctrl+U: Copy URL | Enter: Open In Browser'" \
        --preview-window=down,1,border-none --tmux 90% \
        --bind "enter:become(echo {} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}
