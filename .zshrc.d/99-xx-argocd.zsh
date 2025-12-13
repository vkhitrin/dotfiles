which argocd > /dev/null 2>&1 || return

function argox() {
    # xx {"tags": "argocd", "description": "Manage ArgoCD applications", "subshell": false, "cache": false}
    local EXTRA_BIND_OPTIONS="ctrl-s:execute-silent(argocd app sync {1} --server {9})+reload(source ~/.zshrc.d/xx_functions/__xx_get_argocd_applications;__xx_get_argocd_applications {9}),ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_get_argocd_applications;__xx_get_argocd_applications {9}),ctrl-o:change-preview(argocd app manifests {1} --server {9} 2>/dev/null)+transform-preview-label(printf \" Manifests: %s \" {1})"
    local APPS_TEXT_PROMPT="CTRL+S: Sync App | CTRL+R: Refresh | CTRL+D: Diff | CTRL+L: Logs | CTRL+G: Details | CTRL+O: Manifests | CTRL+P: Toggle Preview"
    local INITIAL_PROMPT="ENTER: Browse Applications"

    __xx_get_argocd_contexts | fzf --header-lines=1 \
        --ansi \
        --wrap \
        --info=inline \
        --layout=reverse-list \
        --border-label " ArgoCD Contexts " \
        --color 'border:#b77a5e,label:#b77a5e,header:#b77a5e:bold' \
        --header "${INITIAL_PROMPT}" \
        --preview-window=right:hidden:wrap \
        --preview '' \
        --bind='start:unbind(ctrl-d)+unbind(ctrl-l)+unbind(ctrl-g)+unbind(ctrl-o)+unbind(ctrl-p)'\
        --bind='enter:'\
'execute-silent(argocd context {1})'\
'+transform-border-label(printf " %s Applications " {1})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_argocd_applications;__xx_get_argocd_applications {2})'\
'+change-preview-window(right:hidden:wrap)'\
"+change-header(${APPS_TEXT_PROMPT})+unbind(enter)+rebind(ctrl-d)+rebind(ctrl-l)+rebind(ctrl-g)+rebind(ctrl-o)+rebind(ctrl-p),"\
'ctrl-d:change-preview(argocd app diff {1} --server {9} 2>/dev/null)+transform-preview-label(printf " Diff: %s " {1}),'\
'ctrl-l:change-preview(argocd app logs {1} --server {9} --tail 100 2>/dev/null)+transform-preview-label(printf " Logs: %s " {1}),'\
'ctrl-g:change-preview(argocd app get {1} --server {9} 2>/dev/null)+transform-preview-label(printf " Details: %s " {1}),'\
'ctrl-p:toggle-preview,'\
${EXTRA_BIND_OPTIONS}\
        --tmux 80%
}
