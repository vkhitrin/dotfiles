which az > /dev/null 2>&1 || return

function azx() {
    # xx ;azure:Activate Azure Subscription globally@FALSE
    local SELECTED_SUBSCRIPTION=$(__xx_construct_azure_accounts | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-u:execute-silent(__xx_unset_azure_account)+reload(__xx_construct_azure_accounts)' --prompt="Filter " \
        --bind='ctrl-r:reload(__xx_construct_azure_accounts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Azure Subscriptions ' --color 'border:#74c7ec,label:#74c7ec,header:#74c7ec:bold,preview-fg:#74c7ec' \
        --preview="echo 'Ctrl-R: Reload List  | Ctrl+U: Unset Active Subscription | Enter: Activate Subscription'" \
        --delimiter="[[:space:]][[:space:]]+" --accept-nth 2 \
        --preview-window=down,1,border-none)
    if [ ! -z ${SELECTED_SUBSCRIPTION} ]; then
        az account set --subscription "${SELECTED_SUBSCRIPTION}"
    fi
}
