which todo > /dev/null 2>&1 || return

function tdx() {
    # xx ;todo:List todo@FALSE
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+R: Refresh | CTRL+E: Edit Task | CTRL+N: New Task"
    BIND_OPTIONS+="--bind=ctrl-e:become:(source ~/.zshrc.d/xx_functions/__xx_edit_todo;__xx_edit_todo {})"
    BIND_OPTIONS+="--bind=ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_todo;__xx_get_todo)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    if [ ! -z "${TMUX}" ]; then
        BIND_OPTIONS+="--bind=f12:become(source ~/.zshrc.d/xx_functions/__xx_delete_todo; __xx_delete_todo {-1};source ~/.zshrc.d/99-xx-todo.zsh; tdx)"
        TEXT_PROMPT+=" | F12: Delete Path"
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
