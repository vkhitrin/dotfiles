function obsx() {
    # xx ;obsidian:View Obsidian notes@FALSE
    local EXTRA_BIND_OPTIONS="ctrl-t:execute-silent(tmux new-window -d '$EDITOR {2}')"
    local NOTES_TEXT_PROMPT="CTRL+T: Open Directory In New Tmux Window"
    local INITIAL_PREVIEW="ENTER: Browse Vault Content"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        EXTRA_BIND_OPTIONS+=",ctrl-o:become(printf %s {} | awk '{\$1=\"\"; sub(/^ /,\"\"); print}' | sed 's/^ *//' | while IFS= read -r line; do \$EDITOR \"\$line\"; done)"
        NOTES_TEXT_PROMPT+=" | CTRL+O: Open Note"
        INITIAL_PREVIEW+=" | CTRL+O: Open Vault"
    fi
    __xx_get_obsidian_vaults ~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian | fzf --header-lines=1 \
        --info=inline \
        --layout=reverse-list \
        --border-label " Obsidian Vaults " \
        --color 'border:#9B73EC,label:#9B73EC,header:#9B73EC:bold,preview-fg:#9B73EC' \
        --preview="echo '${INITIAL_PREVIEW}'" \
        --bind='enter:'\
'transform-border-label(printf " %s Notes " {1})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_obsidian_notes;__xx_get_obsidian_notes {2})'\
"+change-preview(echo '${NOTES_TEXT_PROMPT}')+unbind(enter),"\
${EXTRA_BIND_OPTIONS}\
        --preview-window=down,1,border-none --tmux 80%
}
