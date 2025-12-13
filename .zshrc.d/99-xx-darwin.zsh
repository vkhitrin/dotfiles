[[ "$OSTYPE" == darwin* ]] || return

function lctlx() {
    # xx {"tags": "macOS", "description": "macOS launchctl", "subshell": false, "cache": false}
    __xx_get_macos_launchctl | fzf \
        --ansi \
        --border-label ' macOS launchctl ' --color 'border:#ffffff,label:#ffffff,header:#ffffff:bold,header:#ffffff' \
        --header-lines=1 --info=inline \
        --layout=reverse-list \
        --bind="start:unbind(enter)"
}

function brewsx() {
    # xx {"tags": "macOS,brew", "description": "Homebrew services", "subshell": false, "cache": false}
    local service
    service=$(__xx_get_brew_services | fzf \
        --ansi \
        --border-label ' Homebrew Services ' --color 'border:#ffffff,label:#ffffff,header:#ffffff:bold,header:#ffffff' \
        --header-lines=1 --info=inline --layout=reverse-list \
        --preview-window=right:70%:hidden:wrap \
        --preview 'brew services info {1}' \
        --preview-label=' Info ' \
        --header='CTRL-P: Toggle Preview | CTRL-I: Info (Preview) | CTRL-L: Plist (Preview) | CTRL-S: Toggle Service | CTRL-R: :estart' \
        --bind="start:unbind(enter)" \
        --bind="ctrl-p:toggle-preview" \
        --bind='ctrl-i:change-preview(brew services info {1})+transform-preview-label(echo " Info ")' \
        --bind='ctrl-l:change-preview(brew services info {1} --json | jq -r ".[] | .file" | xargs bat --style=plain --language=xml --color=always)+transform-preview-label(echo " Plist ")' \
        --bind="ctrl-s:accept" \
        --bind="ctrl-r:accept" \
        --expect="ctrl-s,ctrl-r")

    [[ -z "$service" ]] && return

    local key=$(echo "$service" | head -1)
    local selected=$(echo "$service" | tail -1)
    local service_name=$(echo "$selected" | awk '{print $1}')
    local service_status=$(echo "$selected" | awk '{print $2}')

    [[ -z "$service_name" ]] && return

    case "$key" in
        ctrl-s)
            if [[ "$service_status" == "started" ]]; then
                echo "Stopping $service_name..."
                brew services stop "$service_name"
            else
                echo "Starting $service_name..."
                brew services start "$service_name"
            fi
            ;;
        ctrl-r)
            echo "Restarting $service_name..."
            brew services restart "$service_name"
            ;;
    esac
}

