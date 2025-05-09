which kubesess > /dev/null 2>&1 || return

function kctx() {
    # xx ;kubernetes:Activate Kubernetes context for shell@TRUE
    local BIND_OPTIONS=()
    local TEXT_PROMPT="VIEW ONLY MODE"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=ctrl-u:execute-silent(rm -rf ~/.kube/kubesess/cache/)+reload(__xx_get_kubernetes_contexts)"
        BIND_OPTIONS+="--bind=ctrl-r:reload:(__xx_get_kubernetes_contexts)"
        BIND_OPTIONS+="--bind=enter:become(kubesess -v {} context)"
        TEXT_PROMPT="Ctrl-R: Refresh | Ctrl-U: Unset Current Context | Enter: Set Context"
    fi
    local SELECTED_CONTEXT=$(__xx_get_kubernetes_contexts | fzf --info=inline --ansi \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label " Kubernetes Contexts " --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa' \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none \
        ${BIND_OPTIONS[@]}
        
    )
    [ ! -z ${SELECTED_CONTEXT} ] && export KUBECONFIG="${SELECTED_CONTEXT}"
}

