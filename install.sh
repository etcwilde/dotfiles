#!/bin/zsh
# vim:set et sw=2 ts=2 tw=84:
# Install my dotfiles quickly
# Evan Wilde      <etceterawilde@gmail.com>

ln --backup -s "$PWD/tmux/tmux.conf" "$HOME/.tmux.conf"
ln --backup -s "$PWD/zsh/zshrc" "$HOME/.zshrc"
ln --backup -s "$PWD/git/config" "$HOME/.gitconfig"
ln --backup -s "$PWD/git/gitignore" "$HOME/.gitignore"

if [[ $(uname -s) == 'Linux' ]]; then
  if [[ -d "$HOME/.i3" ]]; then
    echo -e "\033[0;33mWarning:\033[0m i3 (~/.i3) folder already exits, create the symbolic link manually"
  else
    ln -s "$PWD/i3" "$HOME/.i3"
  fi
fi

CONFIG="$HOME/.config"

ln --backup -s "$PWD/zsh" "$CONFIG"
ln --backup -s "$PWD/tmux" "$CONFIG"
ln --backup -s "$PWD/nvim" "$CONFIG"

if [[ $(uname -s) == 'Linux' ]]; then
  ln --backup -s "$PWD/termite" "$CONFIG"
  ln --backup -s "$PWD/rofi" "$CONFIG"

  xrdb -merge "$PWD/Xresources"
fi
