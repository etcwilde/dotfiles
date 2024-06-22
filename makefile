# vim:set noet sw=0 ts=2 sts=0 tw=80:
# Evan Wilde 2022 <etceterawilde@gmail.com>

#
# System Config
#
SYSTEM     :=$(shell uname -s)
ARCH       :=$(shell uname -m)
BASE_DIR   :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.phony: install install_Linux install_Darwin git i3 lldb nvim rofi tmux zsh jq

install: install_${SYSTEM}

install_Linux: git jq i3 lldb nvim rofi tmux zsh

install_Darwin: git jq lldb nvim tmux zsh zsh_Darwin

#
# Components
#

#
## git
#

git: ${HOME}/.config/git/config ${HOME}/.config/git/ignore
	@echo "git configuration installed"

${HOME}/.config/git/config: ${HOME}/.config/git
	cp ${BASE_DIR}/git/config ${HOME}/.config/git/config


${HOME}/.config/git/ignore: ${HOME}/.config/git
	cp ${BASE_DIR}/git/ignore ${HOME}/.config/git/ignore

${HOME}/.config/git:
	mkdir -p ${HOME}/.config/git

#
## i3
#

i3: | ${HOME}/.i3
	@echo "i3 configuration installed"

${HOME}/.i3:
	ln -s ${BASE_DIR}/i3 ${HOME}/.i3

#
## jq
#

ifeq (${SYSTEM},Darwin)
JQ_PATH := https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64
JQ_SHA512_SUM :=  "df407cd34378f49ff8866d61a58ce1c367341062325c4c3bd07b0e1ad5d65758a2ede94574b4279e1a0a208a04bac487b7d898450fb614c2b94469d7621e583a  /tmp/jq"
else ifeq (${SYSTEM},Linux)
JQ_PATH := https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
JQ_SHA512_SUM := "c9e585368bcb89d4c5213a31866e9301f03fe27165afcb4a3cdf0ec1be43b0fb7439d71dd9607ccc002622915b40389ee79c67d4c3c54ff95257cb23643b0330  /tmp/jq"
else
	$(warning "no known platform '${SYSTEM}' for jq")
endif

${HOME}/.local/bin:
	mkdir -p ${HOME}/.local/bin

${HOME}/.config:
	mkdir -p ${HOME}/.config

${HOME}/.local/bin/jq: | ${HOME}/.local/bin
	curl -L ${JQ_PATH} > /tmp/jq
	echo ${JQ_SHA512_SUM} | shasum -a 512 -c-
	chmod +x /tmp/jq
	mv /tmp/jq ${HOME}/.local/bin/jq

jq: | ${HOME}/.local/bin/jq

#
## fzf
#

FZF_VERSION := 0.53.0
FZF_BASE_PATH := https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/

ifeq (${ARCH},x86_64)
  FZF_ARCH := amd64
else ifeq (${ARCH},arm64)
  FZF_ARCH := ${ARCH}
else
  $(warning "Unknown architecture '${ARCH}' for fzf")
endif

ifeq (${SYSTEM},Darwin)
  FZF_SYSTEM := darwin
  FZF_FILE := fzf-${FZF_VERSION}-${FZF_SYSTEM}_${FZF_ARCH}.zip
else ifeq (${SYSTEM},Linux)
  FZF_SYSTEM := linux
  FZF_FILE := fzf-${FZF_VERSION}-${FZF_SYSTEM}_${FZF_ARCH}.tar.gz
else
  $(warning no known platform '${SYSTEM}' for fzf)
endif

fzf: | ${HOME}/.local/bin
	curl -L ${FZF_BASE_PATH}${FZF_FILE} > /tmp/${FZF_FILE}
ifeq (${SYSTEM},Darwin)
	unzip /tmp/${FZF_FILE} -d ${HOME}/.local/bin
else ifeq (${SYSTEM},Linux)
	tar xf /tmp/${FZF_FILE} -C ${HOME}/.local/bin
endif

#
## lldb
#

lldb: | ${HOME}/.lldbinit
	@echo "LLDB configuration installed"

${HOME}/.lldbinit:
	ln -s ${BASE_DIR}/lldb/lldbinit ${HOME}/.lldbinit

#
## neovim
#

nvim: | ${HOME}/.config/nvim
	@echo "NeoVim configuration installed"

${HOME}/.config/nvim: ${HOME}/.config
	ln -s ${BASE_DIR}/nvim ${HOME}/.config/nvim

#
## vim
#

vim: ${BASE_DIR}/vim/vimrc | ${HOME}/.vim
	ln -s ${BASE_DIR}/vim/vimrc ${HOME}/.vimrc

${HOME}/.vim:
	ln -s ${BASE_DIR}/vim ${HOME}/.vim

#
## Rofi
#

rofi: | ${HOME}/.config/rofi
	@echo "Rofi configuration installed"

${HOME}/.config/rofi: ${HOME}/.config
	ln -s ${BASE_DIR}/rofi ${HOME}/.config/rofi

#
## Tmux
#

tmux: | ${HOME}/.tmux.conf ${HOME}/.config/tmux
	@echo "Tmux configuration installed"

${HOME}/.tmux.conf:
	ln -s ${BASE_DIR}/tmux/tmux.conf ${HOME}/.tmux.conf

${HOME}/.config/tmux: ${HOME}/.config
	ln -s ${BASE_DIR}/tmux ${HOME}/.config/tmux

#
## Zsh
#

zsh: | ${HOME}/.zshrc ${HOME}/.config/zsh
	@echo "Zsh configuration installed"

${HOME}/.zshrc:
	ln -s ${BASE_DIR}/zsh/zshrc ${HOME}/.zshrc

${HOME}/.config/zsh: ${HOME}/.config
	ln -s ${BASE_DIR}/zsh ${HOME}/.config/zsh

zsh_Darwin:
	bash ${BASE_DIR}/platform/macos/defaults.sh

#
## Alacritty
#
alacritty: ${HOME}/.config/alacritty/alacritty.toml

${HOME}/.config/alacritty/alacritty.toml: ${BASE_DIR}/terminals/alacritty/alacritty.toml
	mkdir -p ${HOME}/.config/alacritty
	cp ${BASE_DIR}/terminals/alacritty/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml
