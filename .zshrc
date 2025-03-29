# Fix editor issue with zsh https://unix.stackexchange.com/questions/602733/how-do-i-figure-out-what-just-broke-my-zsh-shell-beginning-of-line-and-end-of-li
bindkey -e
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey "^[[3~" delete-char

# Environment variables
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

# History options
setopt histignorealldups
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# Completion options
setopt LIST_ROWS_FIRST

# Add tab highlight
zstyle ':completion:*' menu yes=long select
# Add zsh case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Group completion
zstyle ':completion:*' group-name ''
# Add caching to completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.cache/zsh/.zcompcache"
# Completer
zstyle ':completion:*' completer _extensions _complete _approximate
# Detailed file list
zstyle ':completion:*' file-list all
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Colors and decorations
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}󰊕 %d %f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow} %d (errors: %e) %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red} No Matches Found %f'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==48;2;69;71;90;01=48;2;69;71;90;01}:ma=48;2;69;71;90;01")'

# Make deletion behave similar to bash
autoload -U select-word-style
select-word-style bash

# macOS configuration
if [[ $(uname) == "Darwin" ]];then

    export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/sbin:${HOME}/.local/bin:${HOME}/go/bin:${PATH}"

    # Source zsh-completion
    if [[ -d "/opt/homebrew/share/zsh-completions" ]];then
        FPATH="/opt/homebrew/share/zsh-completions:/opt/homebrew/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit promptipnit bashcompinit
        compinit; bashcompinit
    fi

    if [[ -f /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
        source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        FAST_HIGHLIGHT[chroma-man]=
        fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
    fi

    [ -f "/opt/homebrew/share/zsh-autopair/autopair.zsh" ] && source /opt/homebrew/share/zsh-autopair/autopair.zsh

    [ -S "${HOME}/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock" ] && export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock"

    # If ggrep is installed, 'use' it instead of grep
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

    # If mackup is installed as part of system's python
    [ -f "${HOME}/Library/Python/3.9/bin/mackup" ] && alias mackup="${HOME}/Library/Python/3.9/bin/mackup"

    # If clop is installed
    [ -f "/Applications/Clop.app/Contents/SharedSupport/ClopCLI" ] && alias clop="/Applications/Clop.app/Contents/SharedSupport/ClopCLI"

    # If MinIO client installed
    [[ -f "/opt/homebrew/bin/mc" ]] && complete -o nospace -C /opt/homebrew/bin/mc mc

    # macOS aliases
    alias sudoedit='sudo -e'
    alias less='less -rf'
    alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
    alias gcc='/opt/homebrew/bin/gcc-14'

    # Custom aliases
    alias _backup_my_macos="mackup backup -vf && mackup uninstall --force; cp -rf ${HOME}/Library/Preferences/ByHost \"${HOME}/.iCloudDrive/Operating Systems/macOS/Mackup/Library/Preferences\"; open raycast://extensions/raycast/raycast/export-settings-data"
    alias system_python="/usr/bin/python3"
    alias system_pip="/usr/bin/python3 -m pip"

    # Custom GitLab configuration
    if [[ -d "${HOME}/.config/glab-cli/work" ]];then
        alias glab-work="GLAB_CONFIG_DIR=${HOME}/.config/glab-cli/work glab"
    fi

    # Snipkit widget bind only if config file exists
    if [[ -d "${HOME}/Library/Application Support/snipkit" ]]; then
        snipkit-snippets-copy-widget () {
            echoti rmkx
            exec </dev/tty
            snipkit exec
            echoti smkx
        }
        zle -N snipkit-snippets-copy-widget
        bindkey "^Xc" snipkit-snippets-copy-widget
    fi

    # Jira punchout tool
    [ -f "/opt/homebrew/bin/punchout" ] && alias punchout="punchout -db-path=${HOME}/.cache/punchout/punchout.v1.db"

    # Google Cloud SDK Completion
    [ -f "/opt/homebrew/share/zsh/site-functions/_google_cloud_sdk" ] && source /opt/homebrew/share/zsh/site-functions/_google_cloud_sdk

    # Cosmicding
    [ -f "${HOME}/Library/Caches/com.vkhitrin.cosmicding/com.vkhitrin.cosmicding-db.sqlite" ] && \
        export COSMICDING_SQLITE_DATABASE="${HOME}/Library/Caches/com.vkhitrin.cosmicding/com.vkhitrin.cosmicding-db.sqlite"

    # XX (CrossX)
    [ -d "${HOME}/Library/Caches/com.vkhitrin.xx" ] && \
        export XX_CACHE_DIR="${HOME}/Library/Caches/com.vkhitrin.xx"

    # If Twingate Python Script is present
    [ -d "/Users/vkhitrin/Projects/Automation/Tools/Twingate-CLI" ] && alias tgcli="uv --directory='${HOME}/Projects/Automation/Tools/Twingate-CLI' run --no-project --with 'requests' --with 'pandas' ${HOME}/Projects/Automation/Tools/Twingate-CLI/tgcli.py"


fi

# Linux configuration
if [[ $(uname) == "Linux" ]];then

    # Custom environment variables
    # export QT_WAYLAND_DECORATION=adwaita # Client-side decorations for QT5/6 to mimic GTK

    autoload -Uz compinit promptipnit bashcompinit
    compinit; bashcompinit

    if [[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
        source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
    fi


    [ -f "/usr/share/zsh/plugins/zsh-autopair/autopair.zsh" ] && source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

    export PATH="${HOME}/.local/bin:${HOME}/go/bin:${PATH}"

    # Enable SSH Agent (based on a custom systemd service)
    [ -S "/run/user/$(id -u)/ssh-agent.socket" ] && export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

    if which aws_completer > /dev/null 2>&1;then
        complete -C "$(which aws_completer)" aws
    fi

    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word

    # Custom aliases
    alias _backup_my_linux="mackup backup -vf"
    #
    # Cosmicding
    [ -f "${HOME}/.cache/cosmicding/com.vkhitrin.cosmicding-db.sqlite" ] && \
        export COSMICDING_SQLITE_DATABASE="${HOME}/.cache/cosmicding/com.vkhitrin.cosmicding-db.sqlite"
fi

# Enable mise (formerly known as rtx)
if which mise > /dev/null 2>&1;then
    eval "$(mise activate zsh)"
fi

# Enable starship
if which starship > /dev/null 2>&1;then
    eval "$(starship init zsh)"
fi

# Using atuin if it is installed
if which atuin > /dev/null 2>&1;then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

# If bat is installed
if which bat > /dev/null 2>&1;then
    alias cat="bat"
fi

# If batman is installed
if which batman > /dev/null 2>&1;then
    alias man="batman"
fi

# If krew is installed
if [[ $(which kubectl-krew) ]] 2>/dev/null; then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# If kubecolor is installed
if which kubecolor > /dev/null 2>&1;then
    alias kubectl="kubecolor"
    compdef kubecolor=kubectl
fi

# Terminal Editor Discovery
which vim > /dev/null 2>&1 && alias vi='vim'; export EDITOR=vim
which nvim > /dev/null 2>&1 && alias vi='vim'; alias vim='nvim'; export EDITOR=nvim
# Global aliases
alias ls='ls --color=auto -F'
alias ll='ls -l'
alias dotfiles='git --git-dir=${HOME}/Projects/Automation/Setup/dotfiles --work-tree=${HOME}'
# Set default editor
export VISUAL=${EDITOR}

awsx() {
    __construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__construct_aws_profiles_mapping' --prompt="Filter " \
        --bind='ctrl-l:execute-silent(aws-vault login {1} -s)+reload(__construct_aws_profiles_mapping)'\
        --bind='ctrl-d:execute-silent(aws-vault clear {1})+reload(__construct_aws_profiles_mapping)'\
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-L: Login | Ctrl-D: Clear Session | Enter: Exec'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind 'enter:become(aws-vault exec {1})'
}

kctx() {
    local SELECTED_CONTEXT=$(__get_kuberentes_contexts | fzf --info=inline --ansi \
        --bind='ctrl-u:execute-silent(rm -rf ${HOME}/.kube/kubesess/cache/)+reload(__get_kuberentes_contexts)' \
        --bind='ctrl-r:reload:(__get_kuberentes_contexts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Kubernetes Contexts ' --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-U: Unset Current Context | Enter: Set Context'" \
        --preview-window=down,1,border-none \
        --bind 'enter:become(kubesess -v {} context)'
    )
    [ ! -z ${SELECTED_CONTEXT} ] && export KUBECONFIG="${SELECTED_CONTEXT}"
}

gpx() {
    local STARTING_PATH="${1:-${HOME}/Projects/}"
    local SELECTED_DIR=$(__get_git_directories "${STARTING_PATH}" 2>/dev/null | fzf --border-label " Git Projects Under '${STARTING_PATH}' " \
        --color 'border:#fab387,label:#fab387,preview-fg:#fab387' \
        --prompt "Filter " --preview="echo 'Enter: Navigate To Git Project Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

bkmx() {
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_cosmicding_bookmarks | fzf --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__get_cosmicding_bookmarks' --prompt="Filter " \
        --bind="ctrl-u:become(echo {} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Bookmarks ' --color 'border:#b4befe,label:#b4befe,header:#b4befe:bold,preview-fg:#b4befe' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl+U: Copy URL To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 90% \
        --bind "enter:become(echo {} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

cdx() {
    local STARTING_PATH="${1:-${PWD}}"
    local SELECTED_DIR=$(__get_directories "${STARTING_PATH}" | fzf --border-label " All Directories Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,preview-fg:#f38ba8' \
        --prompt "Filter " --preview="echo 'Enter: Navigate To Selected Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

if which jira > /dev/null 2>&1;then
    jipx() {
        jira projects list | fzf --border-label " Jira Projects " --header-lines=1 --layout=reverse-list \
            --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
            --prompt "Filter " --preview="echo 'Enter: Open Project In Browser'" \
            --preview-window=down,1,border-none \
            --bind "enter:become(jira open --project {1})"
    }
    # TODO: Add pagination support
    jiix() {
        local CLIPBOARD_COMMAND
        local OPEN_COMMAND
        if [[ $(uname) == "Darwin" ]];then
            CLIPBOARD_COMMAND="pbcopy"
            OPEN_COMMAND="open"
        elif [[ $(uname) == "Linux" ]]; then
            CLIPBOARD_COMMAND="wl-copy"
            OPEN_COMMAND="xdg-open"
        fi
        local JQL="${1:-(assignee = currentUser()) AND (status !='done')}"
        jira issues list --jql="${JQL}" --plain --columns key,status,summary  2>&1 | fzf --border-label " Jira Issues " \
            --header-lines=1 --layout=reverse-list \
            --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
            --bind="ctrl-u:become(jira open --no-browser {1} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
            --prompt "JQL: ${JQL} " --preview="echo 'Ctrl+U: Copy URL To Clipboard | Enter: Open Issue In Browser'" \
            --preview-window=down,1,border-none \
            --bind "enter:become(jira open {1})"
    }
fi

glpx() {
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_gitlab_projects | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo http://{3}/{1} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 50% \
        --bind "enter:become(echo http://{3}/{1} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

glgx() {
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_gitlab_groups | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 50% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}
