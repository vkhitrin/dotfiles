function gpx() {
    # xx ;git,shell:Navigate to local git projects@PARTIAL
    local STARTING_PATH="${1:-${HOME}/Projects/}"
    local SELECTED_DIR=$(__xx_get_git_directories "${STARTING_PATH}" 2>/dev/null | fzf --border-label " Git Projects Under '${STARTING_PATH}' " \
        --info=inline --color 'border:#fab387,label:#fab387,preview-fg:#fab387' \
        --bind='ctrl-o:execute-silent(cd {}; git open)' \
        --prompt "Filter " --preview="echo 'CTRL+O: Open Remote | Enter: Navigate To Git Project Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

function cdx() {
    # xx ;shell:Navigate to directory@TRUE
    local STARTING_PATH="${1:-${PWD}}"
    local SELECTED_DIR=$(__xx_get_directories "${STARTING_PATH}" | fzf --border-label " All Directories Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,preview-fg:#f38ba8' \
        --prompt "Filter " --preview="echo 'Enter: Navigate To Selected Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}
