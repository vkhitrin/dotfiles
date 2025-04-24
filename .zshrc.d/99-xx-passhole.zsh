which passhole > /dev/null 2>&1 || return

function phx() {
    # xx ;keepass:List keepass entries@FALSE
    local CLIPBOARD_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
    fi

     __xx_get_passhole_entries | fzf --border-label " Keepass Entries " \
        --tmux 80% \
        --header-lines=1 \
        --layout=reverse-list \
        --info=inline --color 'border:#a2b6f0,label:#a2b6f0,preview-fg:#a2b6f0,header:#a2b6f0:bold' \
        --delimiter="[[:space:]]+[[:space:]]+" \
        --prompt "Filter " \
        --preview="echo 'CTRL+R: Refresh | CTRL+B: Copy Username | CTRL+V: Copy Password | CTRL+T: Copy TOTP'" \
        --preview-window=down,1,border-none \
        --bind='ctrl-r:reload:(__xx_get_passhole_entries)' \
        --bind="ctrl-b:become:(passhole show {} --field username | ${CLIPBOARD_COMMAND})" \
        --bind="ctrl-v:become:(passhole show {} --field password | ${CLIPBOARD_COMMAND})" \
        --bind="ctrl-t:become:(passhole show {} --totp | ${CLIPBOARD_COMMAND})" \
        --bind "enter:become()"
}
