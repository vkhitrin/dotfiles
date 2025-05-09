#!/usr/bin/env zsh

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#f4e0dc,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#f4e0dc,hl+:#f38ba8 \
--color=selected-bg:#45475a --highlight-line --no-mouse --tmux 75%"

# PGP
export GPG_TTY=$(tty)

# Include all kubeconfig files
export KUBECONFIG=$(find "$HOME/.kube" -maxdepth 1 -type f | xargs | sed -e 's/ /:/g')

# Application(s)
export KUBECTL_COMMAND="kubectl"
export ANSIBLE_HOME="${HOME}/.local/share/ansible"
export GLAMOUR_STYLE="${HOME}/.config/glamour/catppuccin-mocha.json"

# gcloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1
## Unset account, each shell should define the required account
export CLOUDSDK_CORE_ACCOUNT=""

# ChromaDB
export ANONYMIZED_TELEMETRY="False"

# Azure
export AZURE_CORE_COLLECT_TELEMETRY="false"

# xx
if [ -d "${HOME}/.zshrc.d/xx_functions" ]; then
    fpath=("${HOME}/.zshrc.d/xx_functions" ${fpath})
    for fn in ${HOME}/.zshrc.d/xx_functions/*(N:t); do
      autoload -Uz "$fn"
    done
fi
