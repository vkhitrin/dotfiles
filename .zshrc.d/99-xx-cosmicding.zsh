[[ -n "${COSMICDING_SQLITE_DATABASE}" ]] || return

function bkmx() {
    # xx ;linkding:View bookmarks@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_cosmicding_bookmarks | fzf --header-lines=1 --info=inline \
        --bind="start:unbind(enter)" \
        --bind='ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_cosmicding_bookmarks;__xx_get_cosmicding_bookmarks)' --prompt="Filter " \
        --bind="ctrl-u:execute-silent(echo {} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})" \
        --layout=reverse-list \
        --border-label ' Bookmarks ' --color 'border:#b4befe,label:#b4befe,header:#b4befe:bold,preview-fg:#b4befe' \
        --preview="echo 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+O: Open URL'" \
        --preview-window=down,1,border-none --tmux 90%
}
