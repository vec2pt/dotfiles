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
"

REPLACE_FILES_CP=false

FILES_CP="
    gitconfig
    gitignore_global
"

if [ ! -d "$DIRECTORY" ]; then
    mkdir -pv $DOTFILES_ARCHIVE_DIR
fi

for file in $FILES_LN $FILES_CP; do
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
    path=$(pwd)/.$file
    ln -sv $path ~/.$file
done


if $REPLACE_FILES_CP; then
    for file in $FILES_CP; do
        cp -v ./.$file ~/.$file
    done
fi
