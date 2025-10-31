which aws-vault > /dev/null 2>&1 || return

function awsx() {
    # xx {"tags": "aws", "description": "Activate AWS profile for shell", "subshell": true, "cache": false}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-O: Open SSO URL | CTRL-L: Login | CTRL-D: Clear Session"
    BIND_OPTIONS+="--bind=ctrl-o:execute-silent(source ~/.zshrc.d/xx_functions/__xx_open_aws_sso_url; ${XX_OPEN_COMMAND} \$(__xx_open_aws_sso_url {1}))"
    BIND_OPTIONS+="--bind=ctrl-l:execute-silent(aws-vault login {1} -s)+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    BIND_OPTIONS+="--bind=ctrl-d:execute-silent(aws-vault clear {1})+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(aws-vault exec {1})"
        TEXT_PROMPT+=" | ENTER: Enter Session"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    __xx_construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --tmux 80% \
        ${BIND_OPTIONS[@]}
}

function awsrx() {
    # xx {"tags": "aws", "description": "Change AWS region for active AWS vault in shell", "subshell": true, "cache": false}
    local BIND_OPTIONS=()
    local TEXT_PROMPT=""
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+="ENTER: Pick Region"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    local SELECTED_REGION=$(__xx_construct_aws_regions_for_account | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Enabled Regions For AWS Account ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --tmux 40% \
        ${BIND_OPTIONS[@]}
    )
    if [ ! -z ${SELECTED_REGION} ]; then
        export AWS_REGION="${SELECTED_REGION}"
    fi
}
