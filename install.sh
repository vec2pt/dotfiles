#!/bin/bash

DOTFILES_ARCHIVE_DIR="$HOME/dotfiles_archive"
ZDOTDIR="$HOME/.zsh"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

FILES_LN="
    .zsh/.aliases
    .zsh/.zshrc
    .zshenv
    .condarc
    .pylintrc
    .gitconfig
"

mkdir -pv $DOTFILES_ARCHIVE_DIR
mkdir -pv $DOTFILES_ARCHIVE_DIR/.zsh
mkdir -pv $ZDOTDIR
mkdir -pv "$ZDOTDIR/plugins"


for file in $FILES_LN; do
    if [ -f  ~/$file ]; then
        mv -v ~/$file $DOTFILES_ARCHIVE_DIR/$file`date +"-%Y%m%d"`
    fi
    ln -fsv $SCRIPT_DIR/$file ~/$file
done
