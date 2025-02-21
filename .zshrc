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

    export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/sbin:$HOME/.local/bin:$HOME/go/bin:$PATH

    # Source zsh-completion
    if [[ -d "/opt/homebrew/share/zsh-completions" ]];then
        FPATH="/opt/homebrew/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit promptipnit bashcompinit
        compinit; bashcompinit
    fi

    if [[ -f /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
        source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        FAST_HIGHLIGHT[chroma-man]=
        fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
    fi

    [ -f "/opt/homebrew/share/zsh-autopair/autopair.zsh" ] && source /opt/homebrew/share/zsh-autopair/autopair.zsh

    [ -S "$HOME/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock" ] && export SSH_AUTH_SOCK="$HOME/Library/Group Containers/group.strongbox.mac.mcguill/agent.sock"

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

    # If sublime is installed
    if [[ $(which subl) ]] 2>/dev/null; then
        alias subl='subl --add'
    fi

    # If mackup is installed as part of system's python
    [ -f "$HOME/Library/Python/3.9/bin/mackup" ] && alias mackup="$HOME/Library/Python/3.9/bin/mackup"

    # If clop is installed
    [ -f "/Applications/Clop.app/Contents/SharedSupport/ClopCLI" ] && alias clop="/Applications/Clop.app/Contents/SharedSupport/ClopCLI"

    # If MinIO client installed
    [[ -f /opt/homebrew/bin/mc ]] && complete -o nospace -C /opt/homebrew/bin/mc mc

    # macOS aliases
    alias sudoedit='sudo -e'
    alias less='less -rf'
    alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
    alias gcc='/opt/homebrew/bin/gcc-13'

    # Custom aliases
    alias _backup_my_macos="mackup backup -vf && mackup uninstall --force; cp -rf $HOME/Library/Preferences/ByHost $HOME/.iCloudDrive/Mackup/Library/Preferences; open raycast://extensions/raycast/raycast/export-settings-data"
    alias system_python="/usr/bin/python3"
    alias system_pip="/usr/bin/python3 -m pip"

    # Source zsh-completion
    if [[ -d "${HOME}/.config/glab-cli/work" ]];then
        alias glab-work="GLAB_CONFIG_DIR=${HOME}/.config/glab-cli/work glab"
    fi
fi

# Linux configuration
if [[ $(uname) == "Linux" ]];then

    # Custom environment variables
    export QT_WAYLAND_DECORATION=adwaita # Client-side decorations for QT5/6 to mimic GTK
    export GTK_USE_PORTAL=1 # Use XDG portals in GTK3 apps
    export GTK_DEBUG=portals # Use XDG portals in GTK4 apps

    autoload -Uz compinit promptipnit bashcompinit
    compinit; bashcompinit

    if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
    fi


    [ -f "/usr/share/zsh/plugins/zsh-autopair/autopair.zsh" ] && source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

    export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/sbin:$HOME/.local/bin:$HOME/go/bin:$PATH
    export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH

    # Enable SSH Agent (based on a systemd service)
    [ -S "/run/user/$(id -u)/ssh-agent.socket" ] && export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

    if which aws_completer > /dev/null 2>&1;then
        complete -C "$(which aws_completer)" aws
    fi

    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word

    # Custom aliases
    alias _backup_my_linux="mackup backup -vf"

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
alias ls="ls --color=auto -F"
alias ll='ls -l'
alias dotfiles='git --git-dir=$HOME/Projects/Automation/Setup/dotfiles --work-tree=$HOME'
# Set default editor
export VISUAL=$EDITOR

complete -F _oci_completion -o default oci;

awsx() {
    __construct_aws_profiles_mapping | fzf --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__construct_aws_profiles_mapping' --prompt="Filter " \
        --bind='ctrl-l:execute-silent(aws-vault login {1} -s)+reload(__construct_aws_profiles_mapping)'\
        --bind='ctrl-d:execute-silent(aws-vault clear {1})+reload(__construct_aws_profiles_mapping)'\
        --layout=reverse-list --nth=1,2,3,5 \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-L: Login | Ctrl-D: Clear Session | Enter: Exec'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind 'enter:become(aws-vault exec {1})'
}

kctx() {
    __get_kuberentes_contexts | fzf --info=inline --ansi \
        --bind='ctrl-r:reload:(__get_kuberentes_contexts)' --prompt="Filter " \
        --bind='ctrl-u:execute-silent(kubectl config unset current-context)+reload(__get_kuberentes_contexts)'\
        --layout=reverse-list \
        --border-label ' Kubernetes Contexts ' --color 'border:#89b4fa,label:#89b4fa' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-U: Unset Current Context | Enter: Set Context'" \
        --preview-window=down,1,border-none \
        --bind 'enter:become(kubectl config use-context {})'
}

# Snipkit widget bind only if config file exists
if [[ -d "${HOME}/Library/Application Support/snipkit" ]]; then
    snipkit-snippets-copy-widget () {
        echoti rmkx
        exec </dev/tty
        snipkit copy
        echoti smkx
    }
    zle -N snipkit-snippets-copy-widget
    bindkey "^Xc" snipkit-snippets-copy-widget
fi

autoload -U +X bashcompinit && bashcompinit
