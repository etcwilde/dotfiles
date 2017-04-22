#!/bin/sh
# vim:set et sw=2 ts=4 tw=84:
# Installs my dotfiles quickly and efficiently
# Evan Wilde      <etcwilde@uvic.ca>

ln --backup -s "$PWD/tmux/tmux.conf" "$HOME/.tmux.conf"

CONFIG="$HOME/.config"

ln --backup -s "$PWD/tmux" "$CONFIG"
