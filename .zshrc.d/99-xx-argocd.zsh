which argocd > /dev/null 2>&1 || return

function argox() {
    # xx {"tags": "argocd", "description": "View ArgoCD applications", "subshell": false, "cache": false}

    # Prompts
    local CONTEXT_PROMPT="ENTER: Browse Apps | CTRL+C: Select Context | CTRL+T: Launch TUI"
    local APPS_PROMPT="CTRL+D: Diff | CTRL+L: Logs | CTRL+G: Details | CTRL+O: Manifests | CTRL+P: Preview | CTRL+T: Launch TUI"

    __xx_get_argocd_contexts | fzf --header-lines=1 \
        --ansi \
        --wrap \
        --info=inline \
        --layout=reverse-list \
        --border-label " ArgoCD Contexts " \
        --color 'border:#b77a5e,label:#b77a5e,header:#b77a5e:bold,hl:#b77a5e:bold,hl+:#b77a5e:bold:reverse,bg+:#3c3836' \
        --header "${CONTEXT_PROMPT}" \
        --preview-window=right:hidden:wrap \
        --preview '' \
        --bind='start:unbind(ctrl-d)+unbind(ctrl-l)+unbind(ctrl-g)+unbind(ctrl-o)+unbind(ctrl-p)' \
        --bind="ctrl-c:execute-silent(argocd context {1})+reload(source ~/.zshrc.d/xx_functions/__xx_get_argocd_contexts;__xx_get_argocd_contexts)" \
        --bind="ctrl-t:become(source ~/.zshrc.d/xx_functions/__xx_argocd_launch_tui;__xx_argocd_launch_tui)" \
        --bind="enter:execute-silent(argocd context {1})+transform-border-label(printf \" %s Applications \" {1})+reload(source ~/.zshrc.d/xx_functions/__xx_get_argocd_applications;__xx_get_argocd_applications {2})+change-preview-window(right:hidden:wrap)+change-header(${APPS_PROMPT})+unbind(enter)+unbind(ctrl-c)+rebind(ctrl-d)+rebind(ctrl-l)+rebind(ctrl-g)+rebind(ctrl-o)+rebind(ctrl-p)" \
        --bind="ctrl-d:change-preview(argocd app diff {1} --server {9} 2>/dev/null)+transform-preview-label(printf \" Diff: %s \" {1})" \
        --bind="ctrl-l:change-preview(argocd app logs {1} --server {9} --tail 100 2>/dev/null)+transform-preview-label(printf \" Logs: %s \" {1})" \
        --bind="ctrl-g:change-preview(argocd app get {1} --server {9} 2>/dev/null)+transform-preview-label(printf \" Details: %s \" {1})" \
        --bind="ctrl-o:change-preview(argocd app manifests {1} --server {9} 2>/dev/null)+transform-preview-label(printf \" Manifests: %s \" {1})" \
        --bind="ctrl-p:toggle-preview" \
        --tmux 80%
}

which argonaut > /dev/null 2>&1 || return

function argotui() {
    # xx {"tags": "argocd,tui", "description": "Launch argonaut", "subshell": false, "cache": false}
    __xx_argocd_launch_tui
}
