# Useful links and repos
# https://thevaluable.dev/zsh-install-configure-mouseless/
# https://thevaluable.dev/zsh-completion-guide-examples/
# https://drasite.com/blog/Pimp%20my%20terminal
# https://github.com/Phantas0s/.dotfiles
# https://github.com/ericmurphyxyz/dotfiles
# https://gitlab.com/dwt1/dotfiles

################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

################################################################################
# Options: https://zsh.sourceforge.io/Doc/Release/Options.html#Options
################################################################################

setopt AUTO_CD              # change directory just by typing its name
# setopt GLOB_DOTS            # Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt INTERACTIVE_COMMENTS # allow comments in interactive mode


################################################################################
# Completion
################################################################################

zmodload zsh/complist # Should be called before compinit
autoload -U compinit
compinit -d $XDG_CACHE_HOME/.zcompdump
# _comp_options+=(globdots) # With hidden files

# Options
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# Autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# Defining the Completers
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Colors for files and directory (using default `ls` colors).
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


################################################################################
# History
################################################################################

export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_ALL_DUPS   # delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
setopt SHARE_HISTORY          # share history between terminals
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from each command line being added to the history list.

################################################################################
# Keybindings
################################################################################

# Configure keybindings
bindkey -e                          # emacs key bindings
bindkey ' ' magic-space             # do history expansion on space
bindkey '^[[3~' delete-char         # delete
bindkey '^[[1;5C' forward-word      # ctrl + ->
bindkey '^[[1;5D' backward-word     # ctrl + <-

################################################################################
# Prompt
################################################################################

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# Simple prompt
autoload -U colors && colors
autoload -Uz promptinit
promptinit
PS1=$'%B%F{blue}%~%f\n%F{green}%%%f%b '

# Starship prompt
if test "$TERM" != "linux" && [ -x "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
fi

################################################################################
# Title
################################################################################

DISABLE_AUTO_TITLE="true"
precmd () {print -Pn "\e]0;%~\a"}

################################################################################
# Colors
################################################################################

# Source https://github.com/nordtheme/dircolors/tree/develop
test -r $ZDOTDIR/.dir_colors && eval $(dircolors $ZDOTDIR/.dir_colors)

# fix ls color for folders with 777 permissions
export LS_COLORS=$LS_COLORS':tw=36;01'
export LS_COLORS=$LS_COLORS':ow=36;01'

# Colors for `man`
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\e[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

################################################################################
# Other
################################################################################

# Configure `time` format (ex. `time sleep 2`)
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

################################################################################
# Imports
################################################################################

# Bash utils definitions.
# [ -s "$HOME/.local/bin/bash-utils" ] && \. "$HOME/.local/bin/bash-utils"

# Alias definitions.
if [ -f $ZDOTDIR/.aliases ]; then
    . $ZDOTDIR/.aliases
fi

################################################################################
# Extensions
################################################################################

# enable syntax-highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

################################################################################

# Install Ruby Gems to ~/.gems
# export GEM_HOME="$(gem env user_gemhome)"
# export PATH="$PATH:$GEM_HOME/bin"

# Install nvm (Node Version Manager)
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Cargo / Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
