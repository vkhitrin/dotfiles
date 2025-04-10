# If krew is installed
if [[ $(which kubectl-krew) ]] 2>/dev/null; then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# If kubecolor is installed
if which kubecolor > /dev/null 2>&1;then
    alias kubectl="kubecolor"
    compdef kubecolor=kubectl
fi
