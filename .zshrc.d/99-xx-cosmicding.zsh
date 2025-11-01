[[ -n "${COSMICDING_SQLITE_DATABASE}" ]] || return

function bkmx() {
    # xx {"tags": "linkding", "description": "View bookmarks", "subshell": false, "cache": false}
    __xx_get_cosmicding_bookmarks | fzf --header-lines=1 --info=inline \
        --bind="start:unbind(enter)" \
        --bind='ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_get_cosmicding_bookmarks;__xx_get_cosmicding_bookmarks)' --prompt="> Filter " \
        --bind="ctrl-u:execute-silent(echo {} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="> Filter " \
        --bind "ctrl-o:execute-silent(echo {} | awk '{print \$NF}' | xargs ${XX_OPEN_COMMAND})" \
        --layout=reverse-list \
        --border-label ' Bookmarks ' --color 'border:#b4befe,label:#b4befe,header:#b4befe:bold,header:#b4befe' \
        --header 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+O: Open URL' --tmux 90%
}
