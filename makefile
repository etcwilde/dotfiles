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

FZF_VERSION := 0.57.0
FZF_BASE_PATH := https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/

FZF_SHA256_darwin_amd64 := "cecafb8aec9be56b4559489a4d97a1bb202095c604b00512638003dfadbbf527  /tmp/fzf-0.57.0-darwin_amd64.tar.gz"
FZF_SHA256_darwin_arm64 := "b4e1c5322652bc2672c32dc37993f8d501df7aecb3fa9e545a3d80eca8ae9a2f  /tmp/fzf-0.57.0-darwin_arm64.tar.gz"
FZF_SHA256_linux_amd64 := "a3c087a5f40e8bb4d9bfb26faffa094643df111a469646bef53154a54af9ff92  /tmp/fzf-0.57.0-linux_amd64.tar.gz"
FZF_SHA256_linux_arm64 := "e0b3fd1bb769997907d373b0511401801cd643ce939d26ad42e9fe2836bed625  /tmp/fzf-0.57.0-linux_arm64.tar.gz"

ifeq (${ARCH},x86_64)
  FZF_ARCH := amd64
else ifeq (${ARCH},arm64)
  FZF_ARCH := ${ARCH}
else
  $(warning "Unknown architecture '${ARCH}' for fzf")
endif

ifeq (${SYSTEM},Darwin)
  FZF_SYSTEM := darwin
else ifeq (${SYSTEM},Linux)
  FZF_SYSTEM := linux
else
  $(warning no known platform '${SYSTEM}' for fzf)
endif
FZF_FILE := fzf-${FZF_VERSION}-${FZF_SYSTEM}_${FZF_ARCH}.tar.gz

fzf: | ${HOME}/.local/bin
	curl -L ${FZF_BASE_PATH}${FZF_FILE} > /tmp/${FZF_FILE}
	echo ${FZF_SHA256_${FZF_SYSTEM}_${FZF_ARCH}} | shasum -a 256 -c-
	tar xf /tmp/${FZF_FILE} -C ${HOME}/.local/bin

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
