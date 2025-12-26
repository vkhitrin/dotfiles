[[ -n "${XX_CACHE_DIR}" ]] || return

function cfsx() {
    # xx {"tags": "confluence", "description": "Display cached Confluence spaces", "subshell": false, "cache": true}
    __xx_get_confluence_spaces | fzf --header-lines=1 --info=inline \
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="> Filter " \
        --bind="ctrl-i:execute-silent(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${XX_OPEN_COMMAND})" \
        --bind "ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_refresh_confluence_cache && __xx_refresh_confluence_cache_spaces && __xx_get_confluence_spaces)" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Spaces ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,header:#89b4fa' \
        --header 'CTRL+U: Copy URL | CTRL+I: Copy Key | CTRL+O: Browse | CTRL+R: Refresh' --tmux 80%
}


function cfpx() {
    # xx {"tags": "confluence", "description": "Display cached Confluence pages", "subshell": false, "cache": true}
    __xx_get_confluence_pages | fzf --header-lines=1 --info=inline \
        --preview-window=up:hidden \
        --bind='start:unbind(enter)' \
        --bind="ctrl-u:execute-silent(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="> Filter " \
        --bind "ctrl-o:execute-silent(echo {} | awk -F '   *' '{print \$3}' | xargs ${XX_OPEN_COMMAND})" \
        --bind "ctrl-p:toggle-preview" --preview 'source ~/.zshrc.d/xx_functions/__xx_confluence_render_page; __xx_confluence_render_page $(echo {} | awk -F "   +" "{print \$3}")' \
        --bind "ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_refresh_confluence_cache && __xx_refresh_confluence_cache_pages && __xx_get_confluence_pages)" \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Pages ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,header:#89b4fa' \
        --header 'CTRL+U: Copy URL | CTRL+O: Browse | CTRL+P: Toggle Preview | CTRL+R: Refresh' --tmux 80%
}
