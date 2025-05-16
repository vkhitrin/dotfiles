which aws-vault > /dev/null 2>&1 || return

function awsx() {
    # xx ;aws:Activate AWS profile for shell@TRUE
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-R: Refresh | CTRL-L: Login | CTRL-D: Clear Session"
    BIND_OPTIONS+="--bind=ctrl-r:reload:(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    BIND_OPTIONS+="--bind=ctrl-l:execute-silent(aws-vault login {1} -s)+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    BIND_OPTIONS+="--bind=ctrl-d:execute-silent(aws-vault clear {1})+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(aws-vault exec {1})"
        TEXT_PROMPT+=" | ENTER: Exec"
    else
        BIND_OPTIONS+="--bind=enter:become()"
    fi
    __xx_construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo '${TEXT_PROMPT}'" \
        --preview-window=down,1,border-none --tmux 80% \
        ${BIND_OPTIONS[@]}
}

