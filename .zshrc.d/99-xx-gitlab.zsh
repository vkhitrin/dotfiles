# NOTE: Find a way to bind 'ctrl-b' only when entering the MR view.
[[ -n "${XX_CACHE_DIR}" ]] || return

function glpx() {
    # xx ;gitlab:Display cached GitLab Projects@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
        OPEN_BACKGROUND_COMMAND="open --background"
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
        ALT_KEY_NAME="ALT"
    fi
    local MR_OPEN_MERGE_REQUEST_PROMPT="CTRL+V: View MR"
    local MR_EXTRA_BIND_OPTIONS="ctrl-v:become(source ~/.zshrc.d/xx_functions/__xx_view_gitlab_project_merge_request;__xx_view_gitlab_project_merge_request {5} {2})"
    local CI_PIPELINE_OPEN_MERGE_PROMPT="CTRL+B: View Pipeline | CTRL+T: View Pipeline Trace | ${ALT_KEY_NAME}+ENTER: Open In Browser"
    local CI_PIPELINE_EXTRA_BIND_OPTIONS="ctrl-b:become(source ~/.zshrc.d/xx_functions/__xx_view_gitlab_project_pipeline;__xx_view_gitlab_project_pipeline {5} {6} {1}),ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_trace_gitlab_project_pipeline;__xx_trace_gitlab_project_pipeline {5} {6} {1}),alt-enter:become(echo https://{5}/{6}/-/pipelines/{1} | sed -E 's/\/pipelines\/\(.*\) • #([0-9]+)/\/pipelines\/\1/' | xargs ${OPEN_COMMAND})"

    __xx_get_gitlab_projects | fzf --header-lines=1 --info=inline \
        --bind="start:reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_projects;__xx_get_gitlab_projects)+unbind(ctrl-b,ctrl-v,ctrl-t,alt-enter)" \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_projects;__xx_get_gitlab_projects)" \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {3} | awk '{print \$NF}' | xargs ${OPEN_BACKGROUND_COMMAND})" \
        --bind='ctrl-a:'\
'transform-border-label(printf " %s Open Merge Requests " {1})'\
'+rebind(ctrl-v)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_open_merge_requests;__xx_get_gitlab_project_open_merge_requests {3} {1})'\
"+change-preview(echo '${MR_OPEN_MERGE_REQUEST_PROMPT}')+unbind(enter,ctrl-r,ctrl-u,ctrl-i,ctrl-o,ctrl-p,ctrl-b,ctrl-t,alt-enter)"\
"+transform-query(echo ''),${MR_EXTRA_BIND_OPTIONS}"\
        --bind='ctrl-p:'\
'transform-border-label(printf " %s Pipelines " {1})'\
'+rebind(ctrl-b,ctrl-t,alt-enter)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_pipelines;__xx_get_gitlab_project_pipelines {3} {1})'\
"+change-preview(echo '${CI_PIPELINE_OPEN_MERGE_PROMPT}')+unbind(enter,ctrl-r,ctrl-u,ctrl-i,ctrl-o,ctrl-a,ctrl-v)"\
"+transform-query(echo ''),${CI_PIPELINE_EXTRA_BIND_OPTIONS}"\
        --delimiter="[[:space:]][[:space:]]+" \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+A: Show 100 Open MR | CTRL+P: Show 100 Pipelines | CTRL+O: Open In Background | ENTER: Open Project In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

function glgx() {
    # xx ;gitlab:Display cached GitLab Groups@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
        OPEN_BACKGROUND_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __xx_get_gitlab_groups | fzf --header-lines=1 --info=inline \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_groups;__xx_get_gitlab_groups)" \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind "ctrl-o:execute-silent(echo {3} | awk '{print \$NF}' | xargs ${OPEN_BACKGROUND_COMMAND})" \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'CTRL-R: Refresh | CTRL+U: Copy URL | CTRL+I: Copy ID | ENTER: Open Group In Browser'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

