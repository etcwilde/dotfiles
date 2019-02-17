#!/bin/sh
# vim:set et sw=2 ts=4 tw=84:
# Installs my dotfiles quickly and efficiently
# Evan Wilde      <etcwilde@uvic.ca>

ln --backup -s "$PWD/tmux/tmux.conf" "$HOME/.tmux.conf"
ln --backup -s "$PWD/zsh/zshrc" "$HOME/.zshrc"
ln --backup -s "$PWD/git/config" "$HOME/.gitconfig"
ln --backup -s "$PWD/git/gitignore" "$HOME/.gitignore"

if [ -d "$HOME/.i3" ]; then
  echo -e "\033[0;33mWarning:\033[0m i3 (~/.i3) folder already exits, create the symbolic link manually"
else
  ln --backup -s "$PWD/i3" "$HOME/.i3"
fi

if [ -d "$HOME/.git" ]; then
  echo -e "\033[0;33mWarning:\033[0m Git (~/.git) folder already exits, create the symbolic link manually"
else
  ln --backup -s "$PWD/git/template" "$HOME/.git"
fi


CONFIG="$HOME/.config"

ln --backup -s "$PWD/zsh" "$CONFIG"
ln --backup -s "$PWD/termite" "$CONFIG"
ln --backup -s "$PWD/tmux" "$CONFIG"
ln --backup -s "$PWD/nvim" "$CONFIG"

xrdb -merge "$PWD/Xresources"
