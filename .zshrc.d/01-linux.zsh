[[ "$OSTYPE" == linux* ]] || return

# Custom environment variables
# export QT_WAYLAND_DECORATION=adwaita # Client-side decorations for QT5/6 to mimic GTK
autoload -Uz compinit promptipnit bashcompinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit; bashcompinit
else
    compinit -C; bashcompinit
fi

if [[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
    source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    fast-theme XDG:catppuccin-mocha > /dev/null 2>/dev/null
fi


[ -f "/usr/share/zsh/plugins/zsh-autopair/autopair.zsh" ] && source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

export PATH="${HOME}/.local/bin:${HOME}/go/bin:${HOME}/.cargo/bin:${PATH}"

# Enable SSH Agent (based on a custom systemd service)
[ -S "/run/user/$(id -u)/ssh-agent.socket" ] && export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

if which aws_completer > /dev/null 2>&1;then
    complete -C "$(which aws_completer)" aws
fi

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Custom aliases
alias _backup_my_linux="mackup backup -vf && mackup link uninstall --force"
#
# Cosmicding
[ -f "${HOME}/.cache/cosmicding/com.vkhitrin.cosmicding-db.sqlite" ] && \
    export COSMICDING_SQLITE_DATABASE="${HOME}/.cache/cosmicding/com.vkhitrin.cosmicding-db.sqlite"
