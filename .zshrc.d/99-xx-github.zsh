function ghoix() {
    # xx {"tags": "github", "description": "Display my open GitHub issues", "subshell": false, "cache": false}
    __xx_get_github_open_issues | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="start:unbind(enter)" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${XX_OPEN_COMMAND})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_github_issue; __xx_preview_github_issue {4} {3} {6}" \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitHub Issues ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,header:#bfffd2' \
        --header 'CTRL+U: Copy URL | CTRL+O: Browse | CTRL+P: Toggle Preview' --tmux 80%
}
function ghomrx() {
    # xx {"tags": "github", "description": "Display my open GitHub pull requests", "subshell": false, "cache": false}
    local ALT_KEY_NAME
    if [[ $(uname) == "Darwin" ]];then
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        ALT_KEY_NAME="ALT"
    fi

    __xx_get_github_open_pull_requests | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="start:unbind(enter)" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${XX_OPEN_COMMAND})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_github_pull_request; __xx_preview_github_pull_request {4} {3} {6}" \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitHub Pull Requests ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,header:#bfffd2' \
        --header 'CTRL+U: Copy URL | CTRL+O: Browse | CTRL+P: Toggle Preview' --tmux 80%
}

function ghrx() {
    # xx {"tags": "github", "description": "Display cached GitHub Repositories", "subshell": false, "cache": true}
    __xx_get_github_repositories | fzf --ansi --header-lines=2 --info=inline \
        --bind="start:unbind(ctrl-v,ctrl-t,enter)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_github_repositories_to_sqlite;__xx_cache_github_repositories_to_sqlite)+reload(source ~/.zshrc.d/xx_functions/__xx_get_github_repositories;__xx_get_github_repositories)" \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(${XX_OPEN_COMMAND} {3})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_github_repository; __xx_preview_github_repository {1} {2} {3}" \
        --delimiter="[[:space:]][[:space:]]+" \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' GitHub Projects ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,header:#bfffd2' \
        --header 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+O: Browse | CTRL+P: Toggle Preview | CTRL+R: Refresh Cache' --tmux 80% \
        --bind="enter:become(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'open' {})"
}

function ghnx() {
    # xx {"tags": "github", "description": "Display GitHub notifications", "subshell": false, "cache": true}
    __xx_get_github_notifications | fzf --ansi --header-lines=2 --info=inline \
        --bind="start:unbind(ctrl-v,ctrl-t,enter)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_github_notifications_to_sqlite;__xx_cache_github_notifications_to_sqlite)+reload(source ~/.zshrc.d/xx_functions/__xx_get_github_notifications;__xx_get_github_notifications)" \
        --bind="ctrl-o:execute-silent(source ~/.zshrc.d/xx_functions/__xx_open_github_notification;__xx_open_github_notification {1})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_github_notification; __xx_preview_github_notification {1}" \
        --delimiter="[[:space:]][[:space:]]+" \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' GitHub Notifications ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,header:#bfffd2' \
        --header 'CTRL+O: Open in Browser | CTRL+P: Toggle Preview | CTRL+R: Refresh Cache' --tmux 80%
}

