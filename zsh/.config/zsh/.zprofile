################################################################################
# Configuring $PATH
################################################################################

# https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

################################################################################
# Window manager
################################################################################

# https://wiki.archlinux.org/title/Sway#Automatically_on_TTY_login
# if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
#     exec sway
# fi

# https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
