[[ -n "${XX_CACHE_DIR}" ]] || return

function glpx() {
    # xx {"tags": "gitlab", "description": "Display cached GitLab Projects", "subshell": false, "cache": true}
    local MR_OPEN_MERGE_REQUEST_PROMPT="CTRL-O: Browse | CTRL-P: Toggle Preview"
    local CI_PIPELINE_OPEN_MERGE_PROMPT="CTRL-O: Browse | CTRL-P: Toggle Preview | CTRL-T: View Pipeline TUI"

    __xx_get_gitlab_projects | fzf --ansi --header-lines=2 --info=inline \
        --bind="start:unbind(ctrl-v,ctrl-t,enter)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_gitlab_projects_to_sqlite;__xx_cache_gitlab_projects_to_sqlite)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_projects;__xx_get_gitlab_projects)" \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="> Filter " \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" --prompt="> Filter " \
        --bind "ctrl-o:execute-silent(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'browser' {})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_gitlab_project; __xx_preview_gitlab_project {1} {2} {3}" \
        --bind='ctrl-a:'\
'transform-border-label(printf " %s Open Merge Requests " {1})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_open_merge_requests;__xx_get_gitlab_project_open_merge_requests {3} {1})'\
"+change-header(${MR_OPEN_MERGE_REQUEST_PROMPT})+unbind(ctrl-u,ctrl-i,ctrl-s,ctrl-t,alt-enter,enter)+rebind(ctrl-o)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_gitlab_merge_request; __xx_preview_gitlab_merge_request {1} {2} {5})"\
"+rebind(ctrl-v,ctrl-p)"\
        --bind='ctrl-s:'\
'transform-border-label(printf " %s Pipelines " {1})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_project_pipelines;__xx_get_gitlab_project_pipelines {3} {1})'\
"+change-header(${CI_PIPELINE_OPEN_MERGE_PROMPT})+unbind(ctrl-u,ctrl-i,ctrl-a,ctrl-v,alt-enter,enter)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_view_gitlab_project_pipeline; __xx_view_gitlab_project_pipeline {5} {6} {1})"\
"+rebind(ctrl-p,ctrl-t)"\
        --bind="ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_launch_gitlab_pipeline_tui; __xx_launch_gitlab_pipeline_tui {5} {6} {1})"\
        --delimiter="[[:space:]][[:space:]]+" \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,header:#fca326' \
        --header 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+A: Show 100 Open MR | CTRL+S: Show 100 Pipelines | CTRL+O: Browse | CTRL+P: Toggle Preview | CTRL+R: Refresh Cache' \
        --tmux 80% \
        --bind="enter:become(source ~/.zshrc.d/xx_functions/__xx_smart_gitlab_open;__xx_smart_gitlab_open 'open' {})"
}

function glgx() {
    # xx {"tags": "gitlab", "description": "Display cached GitLab Groups", "subshell": false, "cache": true}
    __xx_get_gitlab_groups | fzf --header-lines=2 --info=inline \
        --bind="start:unbind(enter)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_gitlab_groups_to_sqlite;__xx_cache_gitlab_groups_to_sqlite)+reload(source ~/.zshrc.d/xx_functions/__xx_get_gitlab_groups;__xx_get_gitlab_groups)" \
        --bind="ctrl-u:execute-silent(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind="ctrl-i:execute-silent(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --prompt="> Filter " \
        --bind "ctrl-o:execute-silent(echo {3} | awk '{print \$NF}' | xargs ${XX_OPEN_COMMAND})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_gitlab_group; __xx_preview_gitlab_group {1} {2} {3}" \
        --delimiter="[[:space:]][[:space:]]+" \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,header:#fca326' \
        --header 'CTRL+U: Copy URL | CTRL+I: Copy ID | CTRL+O: Browse | CTRL+P: Toggle Preview | CTRL+R: Refresh Cache' \
        --tmux 80%
}

function glomx() {
    # xx {"tags": "gitlab", "description": "Display my open GitLab Merge Requests", "subshell": false, "cache": false}
    local ALT_KEY_NAME
    if [[ $(uname) == "Darwin" ]];then
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        ALT_KEY_NAME="ALT"
    fi

    __xx_get_gitlab_my_open_merge_requests | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="start:unbind(enter)" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | ${XX_CLIPBOARD_COMMAND})" \
        --bind "ctrl-o:execute-silent(echo {6} | xargs ${XX_OPEN_COMMAND})" \
        --bind="ctrl-p:toggle-preview" \
        --preview-window="right:70%:hidden:wrap" \
        --preview="source ~/.zshrc.d/xx_functions/__xx_preview_gitlab_merge_request; __xx_preview_gitlab_merge_request {3} {4}!{3} {5}" \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitLab Merge Requests ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,header:#fca326' \
        --header 'CTRL+U: Copy URL | CTRL+O: Browse | CTRL+P: Toggle Preview' \
        --tmux 80%
}
