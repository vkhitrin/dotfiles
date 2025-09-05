if [[ -d "${HOME}/.zshrc.d/fzf" ]];then
    for CONF in ${HOME}/.zshrc.d/fzf/*.sh; source ${CONF}
    unset CONF
else
    return
fi
