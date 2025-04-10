# Fix editor issue with zsh https://unix.stackexchange.com/questions/602733/how-do-i-figure-out-what-just-broke-my-zsh-shell-beginning-of-line-and-end-of-li
bindkey -e
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey "^[[3~" delete-char

xx-widget () {
    xx | xargs zsh -i -c
}
zle -N xx-widget
bindkey "^X^X" xx-widget
