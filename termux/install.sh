#!/bin/bash

FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFontMono-Regular.ttf"
DEST_FILE="$HOME/.termux/font.ttf"

if [[ $HOME != *"com.termux"* ]]; then
    echo "The com.termux directory is not found in the HOME path. Exiting..."
    exit 1
fi

# install dependencies
pkg install wget getconf

wget -q -O $DEST_FILE $FONT_URL 

# Reload Termux settings
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null