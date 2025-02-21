# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Custom env variables
export IS_SERVER=false

# FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--tmux"

# PGP
export GPG_TTY=$(tty)

# Include all kubeconfig files
export KUBECONFIG=$(find "$HOME/.kube" -maxdepth 1 -type f | xargs | sed -e 's/ /:/g')

# Application(s)
export KUBECTL_COMMAND="kubectl"
export ANSIBLE_HOME="${HOME}/.local/share/ansible"
# export AWS_CONFIG_FILE="${HOME}/.config/aws/config"
# export AWS_SHARED_CREDENTIALS_FILE="${HOME}/.config/aws/credentials"
# export CARGO_HOME="${HOME}/.local/share/cargo"
# export CQL_HISTORY="${HOME}/.local/share/cassandra/cqlsh_history"
# export CLICKHOUSE_HISTORY_FILE="${HOME}/.local/share/"

__construct_aws_profiles_mapping() {
    local AWS_VAULT_LIST=$(aws-vault list | sed -e '1,3d')
    (
        echo "Profile,Account ID,Role,Session,Description";
        for PROFILE in $(aws configure list-profiles | grep -v default); do
            local PROFILE_ACCOUNT_ID=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "sso_account_id" -v)
            local PROFILE_ROLE=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "sso_role_name" -v)
            local PROFILE_SESSION=$(echo ${AWS_VAULT_LIST} | grep "${PROFILE}" | awk '{print $3}')
            local PROFILE_DESCRIPTION=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "description" -v)
            echo "${PROFILE},${PROFILE_ACCOUNT_ID},${PROFILE_ROLE},${PROFILE_SESSION},${PROFILE_DESCRIPTION}"
        done
    ) | awk -F ',' '{print $1,$2,$3,$4,$5,$6}' OFS=',' | column -t -s ',' | sed 's/\([^,]*,[^,]*,[^,]*,[^,]*\),/\1,/' 
}

__get_kuberentes_contexts() {
    local contexts=$(kubectl config get-contexts -o name) 
    local current_context=$(kubectl config current-context 2>/dev/null)
    if [[ -n "$current_context" ]]; then
      (echo "$contexts" | awk -v cur="$current_context" '
      {
        if ($0 == cur)
          print "\033[31m" $0 "\033[0m";  # Yellow highlight
        else
          print $0;
      }')
    else
      echo ${contexts}
    fi
}
