[[ "$OSTYPE" == linux* ]] || return

function sctlx() {
    # xx {"tags": "Linux", "description": "Linux systemd user units", "subshell": false, "cache": false}
    __xx_get_systemd_user_units | fzf \
        --ansi \
        --border-label ' systemd User Units ' --color 'border:#ffffff,label:#ffffff,header:#ffffff:bold,header:#ffffff' \
        --header-lines=1 --info=inline \
        --layout=reverse-list \
        --bind="start:unbind(enter)"
}

