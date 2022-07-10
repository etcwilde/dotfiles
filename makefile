# vim:set noet sw=0 ts=2 sts=0 tw=80:
# Evan Wilde 2022 <etceterawilde@gmail.com>

#
# System Config
#
SYSTEM     :=$(shell uname -s)
BASE_DIR   :=${PWD}

.phony: install install_Linux install_Darwin git i3 lldb nvim rofi tmux zsh

install: install_${SYSTEM}

install_Linux: git i3 lldb nvim rofi tmux zsh

install_Darwin: git lldb nvim tmux zsh

#
# Components
#

#
## git
#

git: ${HOME}/.gitignore ${HOME}/.gitconfig
	@echo "git configuration installed"

${HOME}/.gitignore:
	ln -s ${BASE_DIR}/git/gitignore ${HOME}/.gitignore

${HOME}/.gitconfig:
	ln -s ${BASE_DIR}/git/config ${HOME}/.gitconfig

#
## i3
#

i3: ${HOME}/.i3
	@echo "i3 configuration installed"

${HOME}/.i3:
	ln -s ${BASE_DIR}/i3 ${HOME}/.i3

#
## lldb
#

lldb: ${HOME}/.lldbinit
	@echo "LLDB configuration installed"

${HOME}/.lldbinit:
	ln -s ${BASE_DIR}/lldb/lldbinit ${HOME}/.lldbinit

#
## neovim
#

nvim: ${HOME}/.config/nvim
	@echo "NeoVim configuration installed"

${HOME}/.config/nvim:
	ln -s ${BASE_DIR}/nvim ${HOME}/.config/nvim

#
## Rofi
#

rofi: ${HOME}/.config/rofi
	@echo "Rofi configuration installed"

${HOME}/.config/rofi:
	ln -s ${BASE_DIR}/rofi ${HOME}/.config/rofi

#
## Tmux
#

tmux: ${HOME}/.tmux.conf ${HOME}/.config/tmux
	@echo "Tmux configuration installed"

${HOME}/.tmux.conf:
	ln -s ${BASE_DIR}/tmux/tmux.conf ${HOME}/.tmux.conf

${HOME}/.config/tmux:
	ln -s ${BASE_DIR}/tmux ${HOME}/.config/tmux

#
## Zsh
#

zsh: ${HOME}/.zshrc ${HOME}/.config/zsh
	@echo "Zsh configuration installed"

${HOME}/.zshrc:
	ln -s ${BASE_DIR}/zsh/zshrc ${HOME}/.zshrc

${HOME}/.config/zsh:
	ln -s ${BASE_DIR}/zsh ${HOME}/.config/zsh
