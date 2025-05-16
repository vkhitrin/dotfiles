[[ -n "${XX_CACHE_DIR}" ]] || return

function cfsx() {
    # xx ;confluence:Display cached Confluence spaces@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_confluence_spaces | fzf --header-lines=1 --info=inline \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_confluence_spaces;__xx_get_confluence_spaces)" \
        --bind="ctrl-u:become(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Spaces ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+I: Copy Key | ENTER: Open Space In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})"
}

function cfpx() {
    # xx ;confluence:Display cached Confluence pages@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_confluence_pages | fzf --header-lines=1 --info=inline \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_confluence_pages;__xx_get_confluence_pages)" \
        --bind="ctrl-u:become(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Pages ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+I: Copy Key | ENTER: Open Page In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})"
}
