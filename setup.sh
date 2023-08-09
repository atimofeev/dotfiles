#!/bin/bash

# Exit the script if any command fails
set -e

declare -A links
links["./hyper/hyper.js"]="$HOME/.hyper.js"
links["./vi"]="$HOME/.vimrc"
links["./fish"]="$HOME/.config/fish"
links["./rack"]="$HOME/.Rack2"

create_symlink() {
    local src=$1
    local dest=$2

    if [ ! -e $src ]; then
        echo "Source $src does not exist. Skipping..."
        return
    fi

    if [ -e $dest ]; then
        echo "Removing existing file or symlink at $dest"
        rm -rf $dest
    fi

    mkdir -p $(dirname $dest)

    echo "Creating symlink $src -> $dest"
    ln -s $src $dest
}

echo "Starting dotfiles symlinking..."

# Iterate over the associative array
for src in "${!links[@]}"; do
    dest=${links[$src]}
    create_symlink $src $dest
done

echo "Dotfiles symlinking complete!"