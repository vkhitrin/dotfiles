function gpx() {
    # xx {"tags": "git,shell", "description": "Navigate to local git projects", "subshell": "PARTIAL", "cache": false}
    local STARTING_PATH="${1:-${HOME}/Projects/}"
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+O: Browse | CTRL+T: Open In New Tmux Window"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d -c {})"
    BIND_OPTIONS+="--bind=ctrl-o:execute-silent(cd {}; git open)"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+=" | ENTER: Navigate To Directory"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    local SELECTED_DIR=$(__xx_get_git_directories "${STARTING_PATH}" 2>/dev/null | fzf --border-label " Git Projects Under '${STARTING_PATH}' " \
        --info=inline --color 'border:#fab387,label:#fab387,header:#fab387' \
        --prompt "> Filter " --header "${TEXT_PROMPT}" --scheme=path \
        ${BIND_OPTIONS[@]}
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

function cdx() {
    # xx {"tags": "shell", "description": "Navigate to directory", "subshell": "PARTIAL", "cache": false}
    local STARTING_PATH
    if [ -n "$1" ]; then
        STARTING_PATH="${1}"
    elif [ -n "${XX_CALLBACK_FROM_TMUX_CWD}" ]; then
        STARTING_PATH="${XX_CALLBACK_FROM_TMUX_CWD}"
    else
        STARTING_PATH="${PWD}"
    fi
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+T: Open Directory In New Tmux Window | CTRL+B: Copy Relative Path"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d -c {})"
    BIND_OPTIONS+="--bind=ctrl-b:execute-silent(echo {} | ${XX_CLIPBOARD_COMMAND})"
    BIND_OPTIONS+="--bind=start:unbind(ctrl-d)"
    if [ ! -z "${TMUX}" ]; then
        BIND_OPTIONS+="--bind=delete:become(source ~/.zshrc.d/xx_functions/__xx_delete_path; __xx_delete_path {};source ~/.zshrc.d/99-xx-files.zsh; cdx)"
        TEXT_PROMPT+=" | Delete: Delete Path"
    fi
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+=" | ENTER: Navigate"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    local SELECTED_DIR=$(fd --full-path -H -t d "${STARTING_PATH}" | fzf \
        --border-label " Directories Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,header:#f38ba8' \
        --prompt "> Filter " --header "${TEXT_PROMPT}" --scheme=path \
        ${BIND_OPTIONS[@]}
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

function fdx() {
    # xx {"tags": "shell", "description": "List files in directory", "subshell": "PARTIAL", "cache": false}
    local STARTING_PATH
    if [ -n "$1" ]; then
        STARTING_PATH="${1}"
    elif [ -n "${XX_CALLBACK_FROM_TMUX_CWD}" ]; then
        STARTING_PATH="${XX_CALLBACK_FROM_TMUX_CWD}"
    else
        STARTING_PATH="${PWD}"
    fi
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL+T: Edit File In New Tmux Window | CTRL+B: Copy Relative Path"
    BIND_OPTIONS+="--bind=ctrl-t:execute-silent(tmux new-window -d ${EDITOR} {})"
    BIND_OPTIONS+="--bind=ctrl-b:execute-silent(echo {} | ${XX_CLIPBOARD_COMMAND})"
    BIND_OPTIONS+="--bind=start:unbind(ctrl-d)"
    if [ ! -z "${TMUX}" ]; then
        BIND_OPTIONS+="--bind=delete:become(source ~/.zshrc.d/xx_functions/__xx_delete_path; __xx_delete_path {};source ~/.zshrc.d/99-xx-files.zsh; fdx)"
        TEXT_PROMPT+=" | Delete: Delete Path"
    fi
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+=" | ENTER: Edit File"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    local SELECTED_DIR=$(fd --full-path -H -t f "${STARTING_PATH}" | fzf \
        --border-label " Files Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,header:#f38ba8' \
        --prompt "> Filter " --header "${TEXT_PROMPT}" --scheme=path \
        ${BIND_OPTIONS[@]}
    )
    [ ! -z ${SELECTED_DIR} ] && ${EDITOR} "${SELECTED_DIR}"
}
