which aws-vault > /dev/null 2>&1 || return

function awsx() {
    # xx ;aws:Activate AWS profile for shell@TRUE
    __xx_construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__xx_construct_aws_profiles_mapping' --prompt="Filter " \
        --bind='ctrl-l:execute-silent(aws-vault login {1} -s)+reload(__xx_construct_aws_profiles_mapping)' \
        --bind='ctrl-d:execute-silent(aws-vault clear {1})+reload(__xx_construct_aws_profiles_mapping)' \
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-L: Login | Ctrl-D: Clear Session | Enter: Exec'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind 'enter:become(aws-vault exec {1})'
}

