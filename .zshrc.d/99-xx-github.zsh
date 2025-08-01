function ghoix() {
    # xx ;github:Display my open issues@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
        OPEN_BACKGROUND_COMMAND="open --background"
        ALT_KEY_NAME="Option"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
        ALT_KEY_NAME="ALT"
    fi

    __xx_get_github_open_issues | fzf --header-lines=1 --info=inline \
        --delimiter="[[:space:]][[:space:]]+" \
        --bind="ctrl-u:become(echo {6} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
        --bind "ctrl-b:execute-silent(echo {6} | xargs ${OPEN_BACKGROUND_COMMAND})" \
        --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' My Open GitHub Issues ' --color 'border:#bfffd2,label:#bfffd2,header:#bfffd2:bold,preview-fg:#bfffd2' \
        --preview="echo 'CTRL+U: Copy URL | CTRL+B: Open In Background | ${ALT_KEY_NAME}+ENTER: Open In Browser | ENTER: View Issue'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "alt-enter:become(echo {6} | xargs ${OPEN_COMMAND})" \
        --bind "enter:become(source ~/.zshrc.d/xx_functions/__xx_view_github_issue; __xx_view_github_issue {4} {3} {6})"
}
