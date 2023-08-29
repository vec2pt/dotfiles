#!/bin/bash

DOTFILES_ARCHIVE_DIR=~/dotfiles_archive

FILES_LN="
    aliases
    bash_logout
    bashrc
    condarc
    profile
    zlogout
    zshrc
    nvmrc
    gitconfig
    gitignore_global
"

if [ ! -d "$DIRECTORY" ]; then
    mkdir -pv $DOTFILES_ARCHIVE_DIR
fi

for file in $FILES_LN; do
    if [ -f  ~/.$file ]; then
        if [ ! -f  $DOTFILES_ARCHIVE_DIR/.$file ]; then
            mv -v ~/.$file $DOTFILES_ARCHIVE_DIR
        else
            echo ERROR! .${file} already exists in ${DOTFILES_ARCHIVE_DIR}
            exit 1
        fi
    fi
done

for file in $FILES_LN; do
    path=$(dirname "$0")/.$file
    ln -sv $path ~/.$file
done
