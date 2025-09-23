[[ "$OSTYPE" == darwin* ]] || return

function lctlx() {
    # xx ;macOS:macOS launchctl@FALSE
    __xx_get_macos_launchctl | fzf \
        --ansi \
        --border-label ' macOS launchctl ' --color 'border:#ffffff,label:#ffffff,header:#ffffff:bold,preview-fg:#ffffff' \
        --header-lines=1 --info=inline \
        --layout=reverse-list \
        --bind="start:unbind(enter)"
}

