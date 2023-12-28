#!/usr/bin/env bash

# Hotkeys
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"  # Ctrl-Alt-Up: Free the bind for mc in emacs
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"  # Ctrl-Alt-Down: Free the bind for mc in emacs

# Extensions
https://extensions.gnome.org/extension/4691/pip-on-top/
sudo dnf install gnome-shell-extension-freon lm_sensors
