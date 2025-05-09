which gcloud > /dev/null 2>&1 || return

function gcpx() {
    # xx ;gcp:Activate GCP Account for shell@TRUE
    local BIND_OPTIONS=()
    local TEXT_PROMPT="VIEW ONLY MODE"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=ctrl-r:reload(__xx_construct_google_cloud_sdk_accounts)"
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT="Ctrl-R: Refresh | Enter: Activate Account"
    fi
    local SELECTED_ACCOUNT=$(__xx_construct_google_cloud_sdk_accounts | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GCP Accounts ' --color 'border:#a6e3a1,label:#a6e3a1,header:#a6e3a1:bold,preview-fg:#a6e3a1' \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --tmux 40% \
        ${BIND_OPTIONS[@]}
    )
    if [ ! -z ${SELECTED_ACCOUNT} ]; then
        export CLOUDSDK_CORE_ACCOUNT="${SELECTED_ACCOUNT}"
        export XX_CLOUDSDK_ACTIVE="true"
    fi
}
