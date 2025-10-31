[[ -n "${XX_CACHE_DIR}" ]] || return

function cfsx() {
    # xx {"tags": "confluence", "description": "Display cached Confluence spaces", "subshell": false, "cache": true}
    __xx_get_confluence_spaces | fzf --header-lines=1 --info=inline \
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:execute-silent(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${XX_OPEN_COMMAND})" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Spaces ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+I: Copy Key | CTRL+O: Browse'" \
        --preview-window=down,1,border-none --tmux 80%
}


function cfpx() {
    # xx {"tags": "confluence", "description": "Display cached Confluence pages", "subshell": false, "cache": true}
    __xx_get_confluence_pages | fzf --header-lines=1 --info=inline \
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${XX_OPEN_COMMAND})" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Pages ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'CTRL+U: Copy URL | CTRL-O: Browse'" \
        --preview-window=down,1,border-none --tmux 80%
}
