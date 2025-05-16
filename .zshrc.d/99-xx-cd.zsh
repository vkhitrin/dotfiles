function gpx() {
    # xx ;git,shell:Navigate to local git projects@PARTIAL
    local STARTING_PATH="${1:-${HOME}/Projects/}"
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+O: Open Remote | CTRL+T: Open Directory In New Tmux Window"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d -c {})"
    BIND_OPTIONS+="--bind=ctrl-o:execute-silent(cd {}; git open)"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+=" | ENTER: Navigate To Directory"
    else
        BIND_OPTIONS+="--bind=enter:become()"
    fi
    local SELECTED_DIR=$(__xx_get_git_directories "${STARTING_PATH}" 2>/dev/null | fzf --border-label " Git Projects Under '${STARTING_PATH}' " \
        --info=inline --color 'border:#fab387,label:#fab387,preview-fg:#fab387' \
        --prompt "Filter " --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --scheme=path \
        ${BIND_OPTIONS[@]}
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

function cdx() {
    # xx ;shell:Navigate to directory@PARTIAL
    local STARTING_PATH="${1:-${PWD}}"
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+T: Open Directory In New Tmux Window"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d -c {})"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+=" | ENTER: Navigate To Directory"
    else
        BIND_OPTIONS+="--bind=enter:become()"
    fi
    local SELECTED_DIR=$(__xx_get_directories "${STARTING_PATH}" | fzf \
        --border-label " Directories Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,preview-fg:#f38ba8' \
        --prompt "Filter " --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --scheme=path \
        ${BIND_OPTIONS[@]}
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}
