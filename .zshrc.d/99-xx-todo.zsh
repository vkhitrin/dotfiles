which todo > /dev/null 2>&1 || return

function tdx() {
    # xx ;todo:List todo@FALSE
     __xx_get_todo | fzf --border-label " TODO " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh'" \
        --preview-window=down,1,border-none \
        --bind='ctrl-r:reload:(__xx_get_todo)' \
        --bind "enter:become()"
}
