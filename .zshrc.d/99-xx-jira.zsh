which jira > /dev/null 2>&1 || return

function jipx() {
    # xx ;jira:Query Jira for projects@FALSE
     __xx_get_jira_projects | fzf --border-label " Jira Projects " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | ENTER: Open Project In Browser'" \
        --preview-window=down,1,border-none \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_projects;__xx_get_jira_projects)" \
        --bind "enter:become(jira open --project {1})"
}
# TODO: Add pagination support
function jiix() {
    # xx ;jira:Query Jira for issues@FALSE
    local CLIPBOARD_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
    fi
     __xx_get_jira_issues | fzf --border-label " Jira Issues " \
        --header-lines=2 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_issues;__xx_get_jira_issues)" \
        --bind="ctrl-u:become(jira open --no-browser {2} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:become(echo {2} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | CTRL+U: Copy URL | CTRL-I: Copy KEY | CTRL+O: Open In Browser | ENTER: View Issue'" \
        --preview-window=down,1,border-none \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_jira_issue;__xx_view_jira_issue {2})" \
        --bind "ctrl-o:execute-silent(jira open {2})"
}
function jirx() {
    # xx ;jira:Query Jira for releases@FALSE
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        OPEN_COMMAND="xdg-open"
    fi
     __xx_get_jira_releases | fzf --border-label " Jira Releases " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | ENTER: Open Release In Browser'" \
        --preview-window=down,1,border-none \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_releases;__xx_get_jira_releases)" \
        --bind "enter:become(echo 'https://plainid.atlassian.net/projects/$(cat ${HOME}/.config/.jira/.config.yml | yq '.project.key')/versions/{1}' | xargs ${OPEN_COMMAND})"
}
