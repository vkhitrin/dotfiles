which op >/dev/null 2>&1 || return
[[ "$OSTYPE" == darwin* ]] || return

function opx() {
    # xx {"tags": "1password", "description": "Query 1password database for items", "subshell": false, "cache": false}
     __xx_get_1password_items | fzf --border-label " 1password Items " \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#f9fafe,label:#f9fafe,header:#f9fafe,header:#f9fafe:bold' \
        --bind "start:unbind(enter)" \
        --bind="ctrl-v:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_1password_password;__xx_copy_1password_password \$(echo {} | awk '{print \$NF}')" \
        --bind="ctrl-t:execute-silent(source ~/.zshrc.d/xx_functions/__xx_copy_1password_totp;__xx_copy_1password_totp \$(echo {} | awk '{print \$NF}')" \
        --bind='ctrl-f:become(ID=$(echo {} | awk '\''{print $NF}'\''); source ~/.zshrc.d/xx_functions/__xx_copy_1password_field && __xx_copy_1password_field "$ID" && exec zsh -i -c opx)' \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_refresh_1password_field_cache;__xx_refresh_1password_field_cache \$(echo {} | awk '{print \$NF}')" \
        --bind="f5:execute-silent(source ~/.zshrc.d/xx_functions/__xx_refresh_all_1password_field_caches;__xx_refresh_all_1password_field_caches 8)" \
        --bind "ctrl-p:toggle-preview" \
        --prompt "> Filter " --header 'CTRL+V: Copy Password | CTRL+T: Copy TOTP | CTRL+F: Copy Field | CTRL+R: Refresh Item | F5: Refresh All Items | CTRL+P: Toggle Preview' \
        --preview "source ~/.zshrc.d/xx_functions/__xx_refresh_1password_keychain_entry; __xx_refresh_1password_keychain_entry >/dev/null; op item get \$(echo {} | awk '{print \$NF}') --reveal" \
        --preview-window 'right:hidden:60%:wrap'
}
