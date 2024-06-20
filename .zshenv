export ZDOTDIR="$HOME/.config/zsh"

# Configuring $PATH (or https://wiki.archlinux.org/title/Zsh#Configuring_$PATH)
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
