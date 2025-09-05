which kdbx >/dev/null 2>&1 || return

function kdx() {
    # xx ;keepass:Query KeePass database for entries@FALSE
     __xx_get_kdbx_entries "${HOME}/.config/kdbx_database.txt" | fzf --border-label " KeePass Entries " \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#7391e8,label:#7391e8,preview-fg:#7391e8,header:#7391e8:bold' \
        --bind="ctrl-v:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_kdbx_password;__xx_copy_kdbx_password ${HOME}/.config/kdbx_database.txt {})" \
        --bind="ctrl-t:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_kdbx_totp;__xx_copy_kdbx_totp ${HOME}/.config/kdbx_database.txt {})" \
        --prompt "Filter " --preview="echo 'ENTER: Show Entry | CTRL+V: Copy Password | CTRL+T: Copy TOTP'" \
        --preview-window=down,1,border-none \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_kdbx_entry;__xx_view_kdbx_entry ${HOME}/.config/kdbx_database.txt {})"
}
