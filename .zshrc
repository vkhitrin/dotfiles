for CONF in ${HOME}/.zshrc.d/*.zsh; source ${CONF}
unset CONF
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
