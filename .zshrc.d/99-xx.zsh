source ~/.zshrc.d/xx_functions/__xx_setup_commands
__xx_setup_commands

export XX_CACHE_DIR="${HOME}/.cache/xx"
xx() {
    local cmd="__xx_get_functions | fzf --header-lines=1 \
        --info=inline \
        --ansi \
        --layout=reverse-list \
        --accept-nth 1 \
        --border-label \" xx \" \
        --color 'border:#f4e0dc,label:#f4e0dc,header:#f4e0dc:bold,header:#f4e0dc' \
        --header 'ENTER: Execute Command' --tmux 80%"
    
    if [[ -z "${XX_CALLBACK_FROM_TMUX}" ]]; then
        eval "$cmd" | xargs zsh -i -c
    else
        eval "$cmd"
    fi
}
