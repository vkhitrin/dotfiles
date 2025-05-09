which todo > /dev/null 2>&1 || return

function tdx() {
    # xx ;todo:List todo@FALSE
     __xx_get_todo | fzf --border-label " TODO " \
        --tmux 80% \
        --header-lines=1 \
        --layout=reverse-list \
        --info=inline --color 'border:#f5c2e7,label:#f5c2e7,preview-fg:#f5c2e7,header:#f5c2e7:bold' \
        --delimiter="[[:space:]]+[[:space:]]+" \
        --prompt "Filter " \
        --preview="echo 'CTRL+R: Refresh | CTRL+E: Edit Task | CTRL+N: New Task'" \
        --preview-window=down,1,border-none \
        --bind='ctrl-e:become:(source ~/.zshrc.d/xx_functions/__xx_edit_todo;__xx_edit_todo {})' \
        --bind='ctrl-n:become:(source ~/.zshrc.d/xx_functions/__xx_new_todo;__xx_new_todo)' \
        --bind='ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_todo;__xx_get_todo)' \
        --bind "enter:become()"
}
