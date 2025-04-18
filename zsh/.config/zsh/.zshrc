##############################################################################
#
# Useful links
# https://thevaluable.dev/zsh-install-configure-mouseless/
# https://thevaluable.dev/zsh-completion-guide-examples/
# https://drasite.com/blog/Pimp%20my%20terminal
#
##############################################################################

##############################################################################
# Settings
##############################################################################

# https://zsh.sourceforge.io/Doc/Release/Options.html#Options

# Changing Directories
setopt AUTO_CD              # change directory just by typing its name
# setopt AUTO_PUSHD         # cd push the old directory onto the directory stack
# setopt CDABLE_VARS        # If the argument to a cd command is not a directory, and does not begin with a slash, try to expand the expression as if it were preceded by a ‘~’

# Completion
setopt AUTO_LIST            # Automatically list choices on an ambiguous completion.
unsetopt AUTO_PARAM_SLASH

# Job Control
# setopt AUTO_RESUME        # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt NOTIFY              # report the status of background jobs immediately

# Input/Output
# setopt CORRECT           # auto correct mistakes
# setopt CORRECT_ALL
# setopt RC_QUOTES          # Allow the character sequence ‘’’’ to signify a single quote within singly quoted strings.

# Expansion and Globbing
setopt GLOB_DOTS            # Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt INTERACTIVE_COMMENTS # allow comments in interactive mode
setopt MAGIC_EQUAL_SUBST     # enable filename expansion for arguments of the form ‘anything=expression’
setopt NO_NOMATCH           # hide error message if there is no match for the pattern
setopt NUMERIC_GLOB_SORT     # sort filenames numerically when it makes sense
# setopt NULL_GLOB

# Prompting
setopt PROMPT_SUBST         # enable command substitution in prompt

# Zle
unsetopt BEEP              # turn off all beeps

# History
HISTFILE=$HOME/.cache/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
# setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
# setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from each command line being added to the history list.


# Configure keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action



# Command completion
# enable completion features
autoload -Uz compinit
compinit -d $HOME/.cache/.zcompdump

# Version control systems info
# enable vcs_info
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# zstyle ':vcs_info:git:*' formats '%b'

# Caching the Completion
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "$HOME/.cache/.zcompcache"

zstyle ':completion:*' menu select
# zstyle ':completion:*' menu select=8 select=long

# Defining the Completers
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion Matching Control
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Configure `time` format (ex. `time sleep 2``)
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

##############################################################################
# Prompt / Title
##############################################################################

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# Simple prompt
autoload -U colors && colors
autoload -Uz promptinit
promptinit
PS1=$'%B%F{blue}%~%f\n%F{green}%%%f%b '

if [ -x "$(command -v starship)" ]; then
    # Starship prompt
    eval "$(starship init zsh)"
else
    # Spaceship prompt
    if [ -f $ZDOTDIR/plugins/spaceship/spaceship.zsh ]; then
        . $ZDOTDIR/plugins/spaceship/spaceship.zsh

        SPACESHIP_PROMPT_ADD_NEWLINE=false
        SPACESHIP_ASYNC_SYMBOL=''
        SPACESHIP_DIR_COLOR=blue
    fi
fi

# Title
DISABLE_AUTO_TITLE="true"
precmd () {print -Pn "\e]0;%~\a"}


##############################################################################
# Colors
##############################################################################

# Source https://github.com/nordtheme/dircolors/tree/develop
test -r $ZDOTDIR/.dir_colors && eval $(dircolors $ZDOTDIR/.dir_colors)

# fix ls color for folders with 777 permissions
export LS_COLORS=$LS_COLORS':tw=36;01'
export LS_COLORS=$LS_COLORS':ow=36;01'

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Colors for `man`
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\e[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline


##############################################################################
# Imports
##############################################################################

# Alias definitions.
if [ -f $ZDOTDIR/.aliases ]; then
    . $ZDOTDIR/.aliases
fi

##############################################################################
# Extensions
##############################################################################

# Config `bat`
export BAT_THEME="base16"
export BAT_STYLE="numbers,changes"

# enable syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
elif [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
elif [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
fi

# enable zsh-shift-select https://github.com/jirutka/zsh-shift-select
if [ -f $ZDOTDIR/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh ]; then
    . $ZDOTDIR/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh
fi



################################################################################

# Install Ruby Gems to ~/.gems
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"

# Install nvm (Node Version Manager)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Cargo / Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
