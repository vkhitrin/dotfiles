# If bat is installed
if which bat > /dev/null 2>&1;then
    alias cat="bat"
fi

# If batman is installed
if which batman > /dev/null 2>&1;then
    alias man="batman"
fi
