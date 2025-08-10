################################################################################
# Environment variables
################################################################################

# XDG
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"

# Default programs
# export TERM="alacritty"
export PAGER="less -RF"
export MANPAGER="nvim +Man!"
# [ -n "$DISPLAY" ] && export EDITOR="codium" || export EDITOR="nvim"
# export VISUAL="nvim"
# [ -n "$DISPLAY" ] && export BROWSER="librewolf"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

################################################################################
# Configuring $PATH
################################################################################

# https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

################################################################################
# Programs
################################################################################

# Config `bat`
export BAT_THEME="OneHalfDark"
export BAT_STYLE="numbers,changes"

# Config `fzf`
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
    --layout reverse
    --color=fg:#abb2bf,bg:#282c34,hl:#61afef
    --color=fg+:#c8ccd4,bg+:#3e4451,hl+:#56b6c2
    --color=info:#e5c07b,prompt:#e06c75,pointer:#c678dd
    --color=marker:#98c379,spinner:#c678dd,header:#98c379
'

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
