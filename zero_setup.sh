#!/bin/bash

TMP_DIR="./tmp"

# Create TMP_DIR if it doesn't exist
mkdir -p $TMP_DIR

# Install Hyper terminal
curl -L https://releases.hyper.is/download/rpm -o $TMP_DIR/hyper_install.rpm
sudo dnf install -y $TMP_DIR/hyper_install.rpm

# Install fish and dependencies
sudo dnf install -y fish fzf fd bat

# Run fish commands
fish << FISH_SCRIPT
# Disable greeting
set -g fish_greeting

# Install fisher and plugins
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install \
    jorgebucaran/fisher \
    hauleth/agnoster \
    jorgebucaran/autopair.fish \
    jorgebucaran/replay.fish \
    jethrokuan/z \
    franciscolourenco/done \
    gazorby/fish-abbreviation-tips \
    nickeb96/puffer-fish \
    meaningful-ooo/sponge \
    # yet to learn shortcuts
    #PatrickF1/fzf.fish
    #jethrokuan/fzf
    #joseluisq/gitnow@2.11.0

# Additional configuration for agnoster theme
agnoster powerline
sed -i "s/^  agnoster::context/ #agnoster::context/g" \$HOME/.config/fish/functions/fish_prompt.fish
source \$HOME/.config/fish/functions/fish_prompt.fish

# Config for Done, notification on 25s+ command execution
set -g __done_min_cmd_duration 25000
FISH_SCRIPT