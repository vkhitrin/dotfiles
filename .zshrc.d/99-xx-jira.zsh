which jira > /dev/null 2>&1 || return

function jipx() {
    # xx {"tags": "jira", "description": "Query Jira for projects", "subshell": false, "cache": false}
     __xx_get_jira_projects | fzf --border-label " Jira Projects " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | CTRL+O: Browse'" \
        --preview-window=down,1,border-none \
        --bind "start:unbind(enter)" \
        --bind "ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_projects;__xx_get_jira_projects)" \
        --bind "ctrl-o:become(jira open --project {1} >/dev/null)"
}
# TODO: Add pagination support
function jiix() {
    # xx {"tags": "jira", "description": "Query Jira for issues", "subshell": false, "cache": false}
     __xx_get_jira_issues | fzf --border-label " Jira Issues " \
        --header-lines=2 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_issues;__xx_get_jira_issues)" \
        --bind="ctrl-u:execute-silent(jira open --no-browser {2} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_jira_launch_tui; __xx_jira_launch_tui {2})" \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | CTRL+U: Copy URL | CTRL-I: Copy KEY | CTRL+O: Browse | CTRL+T: JiraTUI | ENTER: View Issue'" \
        --preview-window=down,1,border-none \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_jira_issue;__xx_view_jira_issue {2})" \
        --bind "ctrl-o:execute-silent(jira open {2})"
}
function jirx() {
    # xx {"tags": "jira", "description": "Query Jira for releases", "subshell": false, "cache": false}
     __xx_get_jira_releases | fzf --border-label " Jira Releases " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'CTRL+R: Refresh | CTRL+U: Copy URL | CTRL-O: Browse'" \
        --preview-window=down,1,border-none \
        --bind "start:unbind(enter)" \
        --bind "ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_releases;__xx_get_jira_releases)" \
        --bind "ctrl-u:execute-silent(echo 'https://plainid.atlassian.net/projects/$(cat ${HOME}/.config/.jira/.config.yml | yq '.project.key')/versions/{1}' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo 'https://plainid.atlassian.net/projects/$(cat ${HOME}/.config/.jira/.config.yml | yq '.project.key')/versions/{1}' | xargs ${XX_OPEN_COMMAND})"
}

which jiratui > /dev/null 2>&1 || return

function jtui() {
    # xx {"tags": "jira,tui", "description": "Launch jiratui", "subshell": false, "cache": false}
    __xx_jira_launch_tui
}
