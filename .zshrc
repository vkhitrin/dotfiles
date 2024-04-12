# Fix editor issue with zsh https://unix.stackexchange.com/questions/602732/how-do-i-figure-out-what-just-broke-my-zsh-shell-beginning-of-line-and-end-of-li
bindkey -e
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey "^[[3~" delete-char

# History enhancements
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

# Add tab highlight
zstyle ':completion:*' menu select
# Add zsh case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Group completion
zstyle ':completion:*' group-name ''

# Make deletion behave similar to bash
autoload -U select-word-style
select-word-style bash

# macOS configuration
if [[ $(uname) == "Darwin" ]];then

    export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/sbin:$HOME/.local/bin:$PATH
    # Enable mise (formerly known as rtx)
    [ -f "/opt/homebrew/bin/mise" ] && eval "$(/opt/homebrew/bin/mise activate zsh)"
    # Enable starship
    [ -f "/opt/homebrew/bin/starship" ] && eval "$(/opt/homebrew/bin/starship init zsh)"

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

    # If sublime is installed
    if [[ $(which subl) ]] 2>/dev/null; then
        alias subl='subl --add'
    fi

    # If mackup is installed as part of system's python
    [ -f "$HOME/Library/Python/3.9/bin/mackup" ] && alias mackup="$HOME/Library/Python/3.9/bin/mackup"

    # If clop is installed
    [ -f "/Applications/Clop.app/Contents/SharedSupport/ClopCLI" ] && alias clop="/Applications/Clop.app/Contents/SharedSupport/ClopCLI"

    # If krew is installed
    if [[ $(which kubectl-krew) ]] 2>/dev/null; then
        export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    fi

    # If MinIO client installed
    [[ -f /opt/homebrew/bin/mc ]] && complete -o nospace -C /opt/homebrew/bin/mc mc

    # System aliases
    alias sudoedit='sudo -e'
    alias ls="ls --color=auto -F"
    alias ll='ls -l'
    alias less='less -rf'
    alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
    alias gcc='/opt/homebrew/bin/gcc-13'

    # Custom aliases
    alias _backup_my_macos="mackup backup -vf && mackup uninstall --force; cp -rf $HOME/Library/Preferences/ByHost $HOME/.iCloudDrive/Mackup/Library/Preferences; open raycast://extensions/raycast/raycast/export-settings-data"
    alias system_python="/usr/bin/python3"
    alias system_pip="/usr/bin/python3 -m pip"
    alias dotfiles='git --git-dir=$HOME/Projects/Automation/Setup/dotfiles --work-tree=$HOME'
fi

# Using mcfly if it is installed
# if which mcfly > /dev/null 2>&1;then
#     export MCFLY_FUZZY=0
#     export MCFLY_RESULTS=50
#     export MCFLY_RESULTS_SORT=LAST_RUN
#     export MCFLY_DELETE_WITHOUT_CONFIRM=true
#     export MCFLY_LIGHT=false
#     eval "$(mcfly init zsh)"
# fi

# Using atuin if it is installed
if which atuin > /dev/null 2>&1;then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if which bat > /dev/null 2>&1;then
    alias cat="bat"
fi

if which batman > /dev/null 2>&1;then
    alias man="batman"
fi

# Terminal Editor Discovery
which vim > /dev/null 2>&1 && alias vi='vim'; export EDITOR=vim
which nvim > /dev/null 2>&1 && alias vim='nvim'; export EDITOR=nvim
# Set default editor
export VISUAL=$EDITOR

incognito () {
    if [[ $1 = disable ]] || [[ $1 == d ]]; then
        export HISTFILE=~/.zsh_history
        add-zsh-hook precmd _atuin_precmd
        add-zsh-hook preexec _atuin_preexec
    else
        unset HISTFILE
        add-zsh-hook -d precmd _atuin_precmd
        add-zsh-hook -d preexec _atuin_preexec
    fi
}

_oci_completion() {
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _OCI_COMPLETE=complete $1 ) )
    return 0
}

complete -F _oci_completion -o default oci;

# Snipkit widget bind only if config file exists
# if [[ -d "$HOME/Library/Application Support/snipkit" ]]; then
#     snipkit-snippets-copy-widget () {
#         echoti rmkx
#         exec </dev/tty
#         local snipkit_output=$(mktemp ${TMPDIR:-/tmp}/snipkit.output.XXXXXXXX)
#         snipkit print -o "${snipkit_output}"
#         echoti smkx
#         cat $snipkit_output | pbcopy
#         rm -f $snipkit_output
#     }
#     zle -N snipkit-snippets-copy-widget
#     bindkey "^Xc" snipkit-snippets-copy-widget
# fi

autoload -U +X bashcompinit && bashcompinit

