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
# export PAGER='nvim +Man!'
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
