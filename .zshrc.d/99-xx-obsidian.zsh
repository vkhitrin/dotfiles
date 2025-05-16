function obsx() {
    # xx ;obsidian:Obsidian notes@FALSE
    __xx_get_obsidian_vaults ~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian | column -t -s ',' | fzf --header-lines=1 \
        --info=inline \
        --layout=reverse-list \
        --border-label " Obsidian Vault " \
        --color 'border:#9B73EC,label:#9B73EC,header:#9B73EC:bold,preview-fg:#9B73EC' \
        --preview="echo 'Enter: Browse Vault Content'" \
        --bind="enter:change-border-label({})" \
        --preview-window=down,1,border-none --tmux 80%
}
