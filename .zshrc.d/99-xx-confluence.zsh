[[ -n "${XX_CACHE_DIR}" ]] || return

function cfsx() {
    # xx ;confluence:Display cached Confluence spaces@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_confluence_spaces | fzf --header-lines=1 --info=inline \
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:execute-silent(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Spaces ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+I: Copy Key | CTRL+O: Open In Browser'" \
        --preview-window=down,1,border-none --tmux 80%
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
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Pages ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL+U: Copy URL | CTRL-O: Open In Browser'" \
        --preview-window=down,1,border-none --tmux 80%
}
