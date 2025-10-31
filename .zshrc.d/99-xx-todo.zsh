which todo > /dev/null 2>&1 || return

function tdx() {
    # xx {"tags": "todo", "description": "List todo", "subshell": false, "cache": false}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+R: Refresh | CTRL+E: Edit Task | CTRL+N: New Task"
    BIND_OPTIONS+="--bind=ctrl-e:become:(source ~/.zshrc.d/xx_functions/__xx_edit_todo;__xx_edit_todo {})"
    BIND_OPTIONS+="--bind=ctrl-n:become:(source ~/.zshrc.d/xx_functions/__xx_new_todo;__xx_new_todo)"
    BIND_OPTIONS+="--bind=ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_todo;__xx_get_todo)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    if [ ! -z "${TMUX}" ]; then
        BIND_OPTIONS+="--bind=f10:become(source ~/.zshrc.d/xx_functions/__xx_complete_todo; __xx_complete_todo {-1};source ~/.zshrc.d/99-xx-todo.zsh; tdx)"
        BIND_OPTIONS+="--bind=f12:become(source ~/.zshrc.d/xx_functions/__xx_delete_todo; __xx_delete_todo {-1};source ~/.zshrc.d/99-xx-todo.zsh; tdx)"
        TEXT_PROMPT+=" | F10: Complete | F12: Delete"
    fi
     __xx_get_todo | fzf --border-label " TODO " \
        --tmux 80% \
        --header-lines=1 \
        --layout=reverse-list \
        --info=inline --color 'border:#f5c2e7,label:#f5c2e7,preview-fg:#f5c2e7,header:#f5c2e7:bold' \
        --delimiter="[[:space:]]+[[:space:]]+" \
        --prompt "Filter " \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none \
        ${BIND_OPTIONS[@]}
}
