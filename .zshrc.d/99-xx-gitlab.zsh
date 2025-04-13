[[ -n "${XX_CACHE_DIR}" ]] || return

function glpx() {
    # xx ;gitlab:Display cached GitLab Projects@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_gitlab_projects | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

function glgx() {
    # xx ;gitlab:Display cached GitLab Groups@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_gitlab_groups | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

