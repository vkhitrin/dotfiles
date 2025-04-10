
# Enable starship prompt
if which starship > /dev/null 2>&1;then
    eval "$(starship init zsh)"
fi

# Enable atuin for history search
if which atuin > /dev/null 2>&1;then
    eval "$(atuin init zsh --disable-up-arrow)"
fi
