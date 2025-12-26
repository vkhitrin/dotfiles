# Make deletion behave similar to bash
autoload -U select-word-style
select-word-style bash

# Completion options
setopt LIST_ROWS_FIRST

# Style
## Add tab highlight
zstyle ':completion:*' menu yes=long select
## Add zsh case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
## Group completion
zstyle ':completion:*' group-name ''
## Add caching to completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.cache/zsh/.zcompcache"
## Completer
zstyle ':completion:*' completer _extensions _complete _approximate
## Detailed file list
zstyle ':completion:*' file-list all
## Colors and decorations
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}󰊕 %d %f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow} %d (errors: %e) %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red} No Matches Found %f'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==48;2;69;71;90;01=48;2;69;71;90;01}:ma=48;2;69;71;90;01")'

# if ast-grep is installed
if which sg > /dev/null 2>&1;then
    compdef sg=ast-grep
fi
