#!/bin/bash

# Exit the script if any command fails
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -A links
links["$DIR/hyper/hyper.js"]="$HOME/.hyper.js"
links["$DIR/vi"]="$HOME/.vimrc"
links["$DIR/fish"]="$HOME/.config/fish"
links["$DIR/rack"]="$HOME/.Rack2"

create_symlink() {
    local src=$1
    local dest=$2

    if [ ! -e $src ]; then
        echo "Source $src does not exist. Skipping..."
        return
    fi

    if [ -e $dest ] || [ -L $dest ]; then
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