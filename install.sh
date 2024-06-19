#!/bin/bash

DOTFILES_ARCHIVE_DIR="$HOME/dotfiles_archive"
ZDOTDIR="$HOME/.config/zsh"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

FILES_LN="
    .config/zsh/.zshrc
    .config/zsh/.aliases
    .config/zsh/.dir_colors
    .config/starship.toml
    .zshenv
    .pylintrc
    .gitconfig
"

mkdir -pv $DOTFILES_ARCHIVE_DIR
mkdir -pv $DOTFILES_ARCHIVE_DIR/.config
mkdir -pv $DOTFILES_ARCHIVE_DIR/.config/zsh
mkdir -pv $ZDOTDIR
mkdir -pv "$ZDOTDIR/plugins"


for file in $FILES_LN; do
    if [ -f  ~/$file ]; then
        mv -v ~/$file $DOTFILES_ARCHIVE_DIR/$file`date +"-%Y%m%d"`
    fi
    ln -fsv $SCRIPT_DIR/$file ~/$file
done
