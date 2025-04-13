which kubesess > /dev/null 2>&1 || return

function kctx() {
    # xx ;kubernetes:Activate Kubernetes context for shell@TRUE
    local SELECTED_CONTEXT=$(__xx_get_kuberentes_contexts | fzf --info=inline --ansi \
        --bind='ctrl-u:execute-silent(rm -rf ${HOME}/.kube/kubesess/cache/)+reload(__xx_get_kuberentes_contexts)' \
        --bind='ctrl-r:reload:(__xx_get_kuberentes_contexts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label " Kubernetes Contexts " --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-U: Unset Current Context | Enter: Set Context'" \
        --preview-window=down,1,border-none \
        --bind 'enter:become(kubesess -v {} context)'
    )
    [ ! -z ${SELECTED_CONTEXT} ] && export KUBECONFIG="${SELECTED_CONTEXT}"
}

