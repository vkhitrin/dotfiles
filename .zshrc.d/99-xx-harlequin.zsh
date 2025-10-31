which harlequin >/dev/null 2>&1 || return
[[ "$OSTYPE" == darwin* ]] || return

function hqx() {
    # xx {"tags": "harlequin", "description": "Connect to databases using harlequin", "subshell": "PARTIAL", "cache": false}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+T: Execute Harlequin In New Tmux Window"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d '__xx_execute_harlequin_connection {}')"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(source ~/.zshrc.d/xx_functions/__xx_execute_harlequin_connection;__xx_execute_harlequin_connection {})"
        TEXT_PROMPT+=" | ENTER: Execute Harlequin"
    else
        BIND_OPTIONS+="--bind=enter:become(source ~/.zshrc.d/xx_functions/__xx_execute_harlequin_connection;__xx_execute_harlequin_connection {})"
    fi
     __xx_get_harlequin_connections | fzf --border-label " Harlequin Connections " \
        --layout=reverse-list \
        --info=inline --color 'border:#f9fafe,label:#feffac,preview-fg:#feffac,header:#feffac:bold' \
        --prompt "Filter " --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none \
        ${BIND_OPTIONS[@]}
}
