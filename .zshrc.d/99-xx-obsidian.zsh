function obsx() {
    # xx {"tags": "obsidian", "description": "View Obsidian notes", "subshell": "PARTIAL", "cache": false}
    local EXTRA_BIND_OPTIONS="ctrl-t:execute-silent(tmux new-window -d \"\$EDITOR {2}\"),ctrl-d:become(obsidian-cli daily --vault {3}),ctrl-n:become(obsidian-cli create --vault {3} $(uuidgen))"
    local NOTES_TEXT_PROMPT="CTRL+T: Open Directory In New Tmux Window | CTRL+D: New Daily Note | CTRL+N: New Note | CTRL+P: Toggle Preview"
    local INITIAL_PREVIEW="ENTER: Browse Vault Content"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        EXTRA_BIND_OPTIONS+=",ctrl-o:become(\$EDITOR {2})"
        NOTES_TEXT_PROMPT+=" | CTRL+O: Open Note"
        INITIAL_PREVIEW="ENTER: Browse Vault Content | CTRL+O: Open Vault"
    fi
    __xx_get_obsidian_vaults ~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian | fzf --header-lines=1 \
        --delimiter '\s\s+' \
        --info=inline \
        --layout=reverse-list \
        --border-label " Obsidian Vaults " \
        --color 'border:#9B73EC,label:#9B73EC,header:#9B73EC:bold,header:#9B73EC' \
        --header "${INITIAL_PREVIEW}" \
        --preview-window=right:hidden:wrap \
        --preview 'bat --color=always --style=plain --language=markdown {2} 2>/dev/null || cat {2} 2>/dev/null' \
        --bind='start:unbind(ctrl-p)'\
        --bind='enter:'\
'transform-border-label(printf " %s Notes " {1})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_obsidian_notes;__xx_get_obsidian_notes {2})'\
"+change-header(${NOTES_TEXT_PROMPT})+unbind(enter)+rebind(ctrl-p),"\
'ctrl-p:toggle-preview,'\
${EXTRA_BIND_OPTIONS}\
        --tmux 80%
}
