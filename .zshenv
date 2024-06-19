export ZDOTDIR="$HOME/.config/zsh"

# Configuring $PATH
# https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
typeset -U path PATH
path=(~/.local/bin $path)
export PATH
