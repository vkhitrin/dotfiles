which az > /dev/null 2>&1 || return

function azx() {
    # xx ;azure:Activate Azure Subscription globally@FALSE
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        OPEN_COMMAND="open --background"
    elif [[ $(uname) == "Linux" ]]; then
        OPEN_COMMAND="xdg-open"
    fi
    local SELECTED_SUBSCRIPTION=$(__xx_construct_azure_accounts | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-u:execute-silent(source ~/.zshrc.d/xx_functions/__xx_unset_azure_account;__xx_unset_azure_account)+reload(source ~/.zshrc.d/xx_functions/__xx_construct_azure_accounts;__xx_construct_azure_accounts)' --prompt="Filter " \
        --bind="ctrl-o:execute-silent(${OPEN_COMMAND} 'https://portal.azure.com')" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Azure Subscriptions ' --color 'border:#74c7ec,label:#74c7ec,header:#74c7ec:bold,preview-fg:#74c7ec' \
        --preview="echo 'CTRL-O: Open Azure Portal | CTRL+U: Unset Active Subscription | ENTER: Activate Subscription'" \
        --delimiter="[[:space:]][[:space:]]+" --accept-nth 2 \
        --preview-window=down,1,border-none)
    if [ ! -z ${SELECTED_SUBSCRIPTION} ]; then
        az account set --subscription "${SELECTED_SUBSCRIPTION}"
    fi
}
