[[ "$OSTYPE" == darwin* ]] || return

export PATH="${HOME}/.cargo/bin:/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/sbin:${HOME}/.local/bin:${HOME}/go/bin:${HOME}/.local/share/nvim/mason/bin:${HOME}/.lmstudio/bin:${HOME}/.bun/bin:${PATH}"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"

# Source zsh-completion
if [[ -d "/opt/homebrew/share/zsh-completions" ]];then
    FPATH="/opt/homebrew/share/zsh-completions:/opt/homebrew/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit promptipnit bashcompinit
    if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
        compinit; bashcompinit
    else
        compinit -C; bashcompinit
    fi
fi

if [[ -f /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
    source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    FAST_HIGHLIGHT[chroma-man]=
    fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
fi

[ -f "/opt/homebrew/share/zsh-autopair/autopair.zsh" ] && source /opt/homebrew/share/zsh-autopair/autopair.zsh

[ -S "${HOME}/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock" ] && export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock"

# If ggrep is installed, use it instead
if which ggrep > /dev/null 2>&1; then
    alias grep='ggrep --color'
else
    alias grep='grep --color'
fi

# If gtar is installed, use it instead
if which gtar > /dev/null 2>&1; then
    alias tar='gtar'
fi
#
# If gdate is installed, use it instead
if which gdate > /dev/null 2>&1; then
    alias date='gdate'
fi

# If gcut is installed, use it instead
if which gcut > /dev/null 2>&1; then
    alias cut='gcut'
fi

# If gsed is installed, use it instead
if which gsed > /dev/null 2>&1; then
    alias sed='gsed'
fi

# If MinIO client installed
[[ -f "/opt/homebrew/bin/mc" ]] && complete -o nospace -C /opt/homebrew/bin/mc mc

# macOS aliases
alias sudoedit='sudo -e'
alias less='less -rf'
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
alias gcc='/opt/homebrew/bin/gcc-15'
alias java_home='/usr/libexec/java_home'

# Custom aliases
alias _backup_my_macos="mackup backup -vf && mackup link uninstall --force; cp -rf ${HOME}/Library/Preferences/ByHost \"${HOME}/.iCloudDrive/OperatingSystems/macOS/Mackup/Library/Preferences\"; open raycast://extensions/raycast/raycast/export-settings-data"

# Custom GitLab configuration
if [[ -d "${HOME}/.config/glab-cli/work" ]];then
    alias glab-work="GLAB_CONFIG_DIR=${HOME}/.config/glab-cli/work glab"
fi

# Custom SourceGraph configuration
src-work() {
    SRC_ENDPOINT=$(security find-generic-password -s "sourcegraph-work" 2>/dev/null | grep "acct" | cut -d"\"" -f4)
    SRC_ACCESS_TOKEN=$(security find-generic-password -s "sourcegraph-work" -w 2>/dev/null)
    if [[ -z "$SRC_ENDPOINT" || -z "$SRC_ACCESS_TOKEN" ]]; then
        echo "Error: keychain item 'sourcegraph-work' not found" >&2
        return 1
    fi
    SRC_ENDPOINT="$SRC_ENDPOINT" SRC_ACCESS_TOKEN="$SRC_ACCESS_TOKEN" src "$@"
}

# Snipkit widget bind only if config file exists
if [[ -d "${HOME}/Library/Application Support/snipkit" ]]; then
    snipkit-snippets-exec-widget () {
        echoti rmkx
        exec </dev/tty
        snipkit exec
        echoti smkx
    }
    snipkit-snippets-copy-widget () {
        echoti rmkx
        exec </dev/tty
        snipkit copy
        echoti smkx
    }
    zle -N snipkit-snippets-exec-widget
    bindkey "^X^Z" snipkit-snippets-exec-widget
fi

# Jira punchout tool
[ -f "/opt/homebrew/bin/punchout" ] && alias punchout="punchout -db-path=${HOME}/.cache/punchout/punchout.v1.db"

# Google Cloud SDK Completion
[ -f "/opt/homebrew/share/zsh/site-functions/_google_cloud_sdk" ] && source /opt/homebrew/share/zsh/site-functions/_google_cloud_sdk

# Cosmicding
[ -f "${HOME}/Library/Caches/com.vkhitrin.cosmicding/com.vkhitrin.cosmicding-db.sqlite" ] && \
    export COSMICDING_SQLITE_DATABASE="${HOME}/Library/Caches/com.vkhitrin.cosmicding/com.vkhitrin.cosmicding-db.sqlite"

# xx
[ -d "${HOME}/Library/Caches/com.vkhitrin.xx" ] && \
    export XX_CACHE_DIR="${HOME}/Library/Caches/com.vkhitrin.xx"

# Workaround for libcosmic https://github.com/pop-os/libcosmic/discussions/860
export XDG_DATA_DIRS="/opt/homebrew/share:${XDG_DATA_DIRS}"

# Spacship
SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ORDER=(
    apple_container
    socktainer
    aws
    gcloud
    azure
    kuberenetes
    git_branch
    mise_tools
    directory
    char
)
