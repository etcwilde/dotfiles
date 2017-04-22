#!/bin/sh
# vim:set et sw=2 ts=4 tw=84:
# Installs my dotfiles quickly and efficiently
# Evan Wilde      <etcwilde@uvic.ca>

if [ -d "$HOME/.i3" ]; then
  echo -e "\033[0;33mWarning:\033[0m i3 (~/.i3) folder already exits, create the symbolic link manually"
else
  ln --backup -s "$PWD/git/template" "$HOME/.i3"
fi
