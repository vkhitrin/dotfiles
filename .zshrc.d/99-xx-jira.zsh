which jira > /dev/null 2>&1 || return

function jipx() {
    # xx ;jira:Query Jira for projects@FALSE
     __xx_get_jira_projects | fzf --border-label " Jira Projects " --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --prompt "Filter " --preview="echo 'Enter: Open Project In Browser'" \
        --preview-window=down,1,border-none \
        --bind "enter:become(jira open --project {1})"
}
# TODO: Add pagination support
function jiix() {
    # xx ;jira:Query Jira for issues@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi
    # Workaround https://github.com/ankitpokhrel/jira-cli/issues/834
     __xx_get_jira_issues | sed 's/\[\]/\]/g' | fzf --border-label " Jira Issues " \
        --header-lines=1 --layout=reverse-list \
        --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
        --bind="ctrl-u:become(jira open --no-browser {1} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --prompt "Filter " --preview="echo 'Ctrl+U: Copy URL To Clipboard | Enter: Open Issue In Browser'" \
        --preview-window=down,1,border-none \
        --bind "enter:become(jira open {1})"
}

