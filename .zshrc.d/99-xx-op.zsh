which op >/dev/null 2>&1 || return
[[ "$OSTYPE" == darwin* ]] || return

function opx() {
    # xx {"tags": "1password", "description": "Query 1password database for items", "subshell": false, "cache": false}
     __xx_get_1password_items | fzf --border-label " 1password Items " \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#f9fafe,label:#f9fafe,header:#f9fafe,header:#f9fafe:bold' \
        --bind="ctrl-t:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_1password_totp;__xx_copy_1password_totp {-1})" \
        --prompt "> Filter " --header 'ENTER: Show Item | CTRL+T: Copy TOTP' \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_1password_item;__xx_view_1password_item {-1})"
}
