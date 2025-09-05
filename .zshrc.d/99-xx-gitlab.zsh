[[ -n "${XX_CACHE_DIR}" ]] || return

function glpx() {
    # xx ;gitlab:Display cached GitLab Projects@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi
    local MR_OPEN_MERGE_REQUEST_PROMPT="CTRL-O: Open In Browser | ENTER: View MR"
    local CI_PIPELINE_OPEN_MERGE_PROMPT="CTRL+T: View Pipeline Trace | CTRL-O: Open In Browser | ENTER: View Pipeline "
    local CI_PIPELINE_EXTRA_BIND_OPTIONS="ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_trace_gitlab_project_pipeline;__xx_trace_gitlab_project_pipeline {5} {6} {1}),alt-enter:become(echo https://{5}/{6}/-/pipelines/{1} | sed -E 's/\/pipelines\/\(.*\) • #([0-9]+)/\/pipelines\/\1/' | xargs ${OPEN_COMMAND})"

    __xx_get_gitlab_projects | fzf --ansi --header-lines=1 --info=inline \
        --bind="start:unbind(ctrl-v,ctrl-t,enter)" \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'browser' {})" \
        --bind='ctrl-a:'\
'transform-border-label(printf " %s Open Merge Requests " {1})'\
'+rebind(ctrl-v)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_open_merge_requests;__xx_get_gitlab_project_open_merge_requests {3} {1})'\
"+change-preview(echo '${MR_OPEN_MERGE_REQUEST_PROMPT}')+unbind(ctrl-u,ctrl-i,ctrl-p,ctrl-t,alt-enter)+rebind(ctrl-o)"\
"+transform-query(echo '')+rebind(enter)"\
        --bind='ctrl-p:'\
'transform-border-label(printf " %s Pipelines " {1})'\
'+rebind(ctrl-t,enter)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_pipelines;__xx_get_gitlab_project_pipelines {3} {1})'\
"+change-preview(echo '${CI_PIPELINE_OPEN_MERGE_PROMPT}')+unbind(ctrl-u,ctrl-i,ctrl-a,ctrl-v)"\
"+transform-query(echo ''),${CI_PIPELINE_EXTRA_BIND_OPTIONS}"\
        --delimiter="[[:space:]][[:space:]]+" \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+A: Show 100 Open MR | CTRL+P: Show 100 Pipelines | CTRL+O: Open In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind="enter:become(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'open' {})"
}

function glgx() {
    # xx ;gitlab:Display cached GitLab Groups@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_gitlab_groups | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})" \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+O: Open In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "start:unbind(enter)"
}

function glomx() {
    # xx ;gitlab:Display my open GitLab Merge Requests@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
        OPEN_COMMAND="open --background"
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
        ALT_KEY_NAME="ALT"
    fi

    __xx_get_gitlab_my_open_merge_requests | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${OPEN_COMMAND})" \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitLab Merge Requests ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+O: Open In Browser | ENTER: View MR'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_gitlab_project_merge_request; __xx_view_gitlab_project_merge_request {5} {4}!{3})"
}
