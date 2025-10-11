################################################################################
# Environment variables
# https://wiki.archlinux.org/title/Environment_variables
################################################################################

# XDG
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"

# Default programs
# https://wiki.archlinux.org/title/Environment_variables#Default_programs
# export TERM="alacritty"
export PAGER="less -RF"
# export MANPAGER="nvim +Man!"
export MANPAGER="vim +MANPAGER --not-a-term -"
export EDITOR="nvim"
export VISUAL="nvim"
# [ -n "$DISPLAY" ] && export BROWSER="librewolf"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

################################################################################
# Programs
################################################################################

# Config `bat`
export BAT_THEME="OneHalfDark"
export BAT_STYLE="plain" # "numbers,changes"

# Config `fzf`
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --layout reverse"\
" --color=fg:#abb2bf,bg:#282c34,hl:#61afef"\
" --color=fg+:#c8ccd4,bg+:#353b45,hl+:#56b6c2"\
" --color=info:#e5c07b,prompt:#e06c75,pointer:#c678dd"\
" --color=marker:#98c379,spinner:#c678dd,header:#98c379 "

# Confin `nnn`
export NNN_BMS="h:$HOME;d:$HOME/Documents;g:$HOME/Documents/GitHub"
# export NNN_PLUG='o:fzopen;m:nmount;x:!chmod +x $nnn'
export NNN_FCOLORS='0404040000000600010F0F02'
export NNN_TRASH=1
