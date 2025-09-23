function ghoix() {
    # xx ;github:Display my open GitHub issues@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_github_open_issues | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${OPEN_COMMAND})" \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitHub Issues ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,preview-fg:#bfffd2' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+O: Open In Browser | ENTER: View Issue'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_github_issue; __xx_view_github_issue {4} {3} {6})"
}
function ghomrx() {
    # xx ;github:Display my open GitHub pull requests@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
        ALT_KEY_NAME="ALT"
    fi

    __xx_get_github_open_pull_requests | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${OPEN_COMMAND})" \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitHub Pull Requests ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,preview-fg:#bfffd2' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+O: Open In Browser | ENTER: View PR'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_github_issue; __xx_view_github_issue {4} {3} {6})"
}

function ghrx() {
    # xx ;github:Display cached GitHub Projects@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi
    __xx_get_github_repositories | fzf --ansi --header-lines=2 --info=inline \
        --bind="start:unbind(ctrl-v,ctrl-t,enter)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_github_projects_to_sqlite;__xx_cache_github_projects_to_sqlite)+reload(source ~/.zshrc.d/xx_functions/__xx_get_github_repositories;__xx_get_github_repositories)" \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(${OPEN_COMMAND} {3})" \
        --delimiter="[[:space:]][[:space:]]+" \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitHub Projects ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,preview-fg:#bfffd2' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+O: Open In Browser | CTRL+R: Refresh Cache'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind="enter:become(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'open' {})"
}
