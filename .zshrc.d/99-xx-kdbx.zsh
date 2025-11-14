which kdbx >/dev/null 2>&1 || return

function kdx() {
    # xx {"tags": "keepass", "description": "Query KeePass database for entries", "subshell": false, "cache": false}
     __xx_get_kdbx_entries "${HOME}/.config/kdbx_database.txt" | fzf --border-label " KeePass Entries " \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#7391e8,label:#7391e8,header:#7391e8,header:#7391e8:bold' \
        --bind "start:unbind(enter)" \
        --bind="ctrl-v:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_kdbx_password;__xx_copy_kdbx_password ${HOME}/.config/kdbx_database.txt {})" \
        --bind="ctrl-t:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_kdbx_totp;__xx_copy_kdbx_totp ${HOME}/.config/kdbx_database.txt {})" \
        --bind='ctrl-f:become(echo {} | ~/.zshrc.d/xx_functions/__xx_kdbx_field_wrapper)' \
        --bind "ctrl-p:toggle-preview" \
        --prompt "> Filter " --header 'CTRL+V: Copy Password | CTRL+T: Copy TOTP | CTRL+F: Copy Field | CTRL+P: Toggle Preview' \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_kdbx_entry; __xx_preview_kdbx_entry ${HOME}/.config/kdbx_database.txt {}" \
        --preview-window 'right:hidden:60%:wrap'
}
