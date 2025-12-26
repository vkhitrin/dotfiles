which jira > /dev/null 2>&1 || return

function jipx() {
    # xx {"tags": "jira", "description": "Query Jira for projects", "subshell": false, "cache": false}
     __xx_get_jira_projects | fzf --border-label " Jira Projects " \
        --tmux 90% \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_projects;__xx_get_jira_projects)" \
        --prompt "> Filter " --header 'CTRL+R: Refresh | CTRL+O: Browse' \
        --bind "start:unbind(enter)" \
        --bind "ctrl-o:become(jira open --project {1} >/dev/null)"
}
function jiix() {
    # xx {"tags": "jira", "description": "Query Jira for issues", "subshell": false, "cache": false}
    export XX_JIRA_PAGE="${XX_JIRA_PAGE:-0}"
    export XX_JIRA_LIMIT="${XX_JIRA_LIMIT:-50}"

     __xx_get_jira_issues "" "${XX_JIRA_PAGE}" "${XX_JIRA_LIMIT}" | fzf --border-label " Jira Issues " \
        --tmux 90% \
        --preview-window=right:70%:hidden:wrap \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-r:reload(__xx_get_jira_issues '' \${XX_JIRA_PAGE} \${XX_JIRA_LIMIT})" \
        --bind="ctrl-n:reload([[ \${XX_JIRA_LAST_COUNT:-0} -ge \${XX_JIRA_LIMIT} ]] && export XX_JIRA_PAGE=\$((XX_JIRA_PAGE + XX_JIRA_LIMIT)); __xx_get_jira_issues '' \${XX_JIRA_PAGE} \${XX_JIRA_LIMIT})" \
        --bind="ctrl-b:reload([[ \${XX_JIRA_PAGE} -gt 0 ]] && export XX_JIRA_PAGE=\$((XX_JIRA_PAGE - XX_JIRA_LIMIT)); [[ \${XX_JIRA_PAGE} -lt 0 ]] && export XX_JIRA_PAGE=0; __xx_get_jira_issues '' \${XX_JIRA_PAGE} \${XX_JIRA_LIMIT})" \
        --bind="ctrl-u:execute-silent(jira open --no-browser {2} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_jira_launch_tui; __xx_jira_launch_tui {2})" \
        --bind "ctrl-p:toggle-preview" --preview 'jira issue view --plain --comments 100 {2}' \
        --prompt "> Filter " --header 'CTRL+R: Refresh | CTRL+N: Next Page | CTRL+B: Previous Page | CTRL+U: Copy URL | CTRL+I: Copy KEY | CTRL+O: Browse | CTRL+T: JiraTUI | CTRL+P: Toggle Preview' \
        --bind "start:unbind(enter)" \
        --bind "ctrl-o:execute-silent(jira open {2})"
}
function jirx() {
    # xx {"tags": "jira", "description": "Query Jira for releases", "subshell": false, "cache": false}
     __xx_get_jira_releases | fzf --border-label " Jira Releases " \
        --tmux 90% \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_jira_releases;__xx_get_jira_releases)" \
        --prompt "> Filter " --header 'CTRL+R: Refresh | CTRL+U: Copy URL | CTRL+O: Browse' \
        --bind "start:unbind(enter)" \
        --bind "ctrl-u:execute-silent(echo 'https://plainid.atlassian.net/projects/$(cat ${HOME}/.config/.jira/.config.yml | yq '.project.key')/versions/{1}' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo 'https://plainid.atlassian.net/projects/$(cat ${HOME}/.config/.jira/.config.yml | yq '.project.key')/versions/{1}' | xargs ${XX_OPEN_COMMAND})"
}

which jiratui > /dev/null 2>&1 || return

function jtui() {
    # xx {"tags": "jira,tui", "description": "Launch jiratui", "subshell": false, "cache": false}
    __xx_jira_launch_tui
}
