#!/bin/bash

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $HOME != *"com.termux"* ]]; then
    echo "The com.termux directory is not found in the HOME path. Exiting..."
    exit 1
fi

# Copy the font to Termux configuration directory
cp $CUR_DIR/../fonts/fonts/DejaVuSansMono-Powerline.ttf  $HOME/.termux/font.ttf

# Reload Termux settings
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null