# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Custom env variables
export IS_SERVER=false

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
