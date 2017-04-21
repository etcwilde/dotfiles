#!/bin/sh
# vim:set et sw=2 ts=4 tw=84:
# Installs my dotfiles quickly and efficiently
# Evan Wilde      <etcwilde@uvic.ca>

ln --backup -s "$PWD/zsh/zshrc" "$HOME/.zshrc"
