# Terminal Editor Discovery
which vim > /dev/null 2>&1 && alias vi='vim'; export EDITOR=vim
which nvim > /dev/null 2>&1 && alias vi='vim'; alias vim='nvim'; export EDITOR=nvim
# Set default editor
export VISUAL="${EDITOR}"
