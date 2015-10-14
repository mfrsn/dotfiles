autoload -U colors
colors

# Base16 Shell
if [ -n "$PS1" ]; then
    eval "$(~/src/co/base16-shell/profile_helper.sh)"
fi

