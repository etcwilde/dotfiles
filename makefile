# vim:set noet sw=0 ts=2 sts=0 tw=80:
# Evan Wilde 2022 <etceterawilde@gmail.com>

#
# System Config
#
SYSTEM     :=$(shell uname -s)
ARCH       :=$(shell uname -m)
BASE_DIR   :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.phony: install install_Linux install_Darwin git i3 lldb nvim rofi tmux zsh jq clean clean_Darwin clean_Linux

install: install_${SYSTEM}

install_Linux: git jq i3 lldb nvim rofi tmux zsh

install_Darwin: git jq lldb nvim tmux zsh zsh_Darwin

install_FreeBSD: git lldb nvim tmux zsh

#
# Components
#

#
## git
#

git: ${HOME}/.config/git/config ${HOME}/.config/git/ignore

${HOME}/.config/git/config: ${HOME}/.config/git
	cp ${BASE_DIR}/git/config ${HOME}/.config/git/config


${HOME}/.config/git/ignore: ${HOME}/.config/git
	cp ${BASE_DIR}/git/ignore ${HOME}/.config/git/ignore

${HOME}/.config/git:
	mkdir -p ${HOME}/.config/git

clean_git:
	rm -f ${HOME}/.config/git/config ${HOME}.config/git/ignore

#
## i3
#

i3: | ${HOME}/.i3
	@echo "i3 configuration installed"

${HOME}/.i3:
	ln -s ${BASE_DIR}/i3 ${HOME}/.i3

clean_i3:
	rm ${HOME}/.i3

#
## jq
#

JQ_VERSION := 1.7.1
JQ_BASE_PATH := https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/
JQ_SHA256_linux_amd64 := "5942c9b0934e510ee61eb3e30273f1b3fe2590df93933a93d7c58b81d19c8ff5  /tmp/jq"
JQ_SHA256_linux_arm64 := "4dd2d8a0661df0b22f1bb9a1f9830f06b6f3b8f7d91211a1ef5d7c4f06a8b4a5  /tmp/jq"
JQ_SHA256_macos_amd64 := "4155822bbf5ea90f5c79cf254665975eb4274d426d0709770c21774de5407443  /tmp/jq"
JQ_SHA256_macos_arm64 := "0bbe619e663e0de2c550be2fe0d240d076799d6f8a652b70fa04aea8a8362e8a  /tmp/jq"

ifeq (${ARCH},x86_64)
JQ_ARCH := amd64
else ifeq (${ARCH},arm64)
JQ_ARCH := arm64
else
$(warning "Unknown architecture '${ARCH}' for jq")
endif

ifeq (${SYSTEM},Darwin)
JQ_SYSTEM := macos
else ifeq (${SYSTEM},Linux)
JQ_SYSTEM := linux
else
$(warning "Unknown system '${SYSTEM}' for jq")
endif

JQ_FILE := jq-${JQ_SYSTEM}-${JQ_ARCH}

${HOME}/.local/bin:
	mkdir -p ${HOME}/.local/bin

${HOME}/.config:
	mkdir -p ${HOME}/.config

${HOME}/.local/bin/jq: | ${HOME}/.local/bin
	curl -L ${JQ_BASE_PATH}${JQ_FILE} > /tmp/jq
	echo ${JQ_SHA256_${JQ_SYSTEM}_${JQ_ARCH}} | shasum -a 256 -c-
	chmod +x /tmp/jq
	mv /tmp/jq ${HOME}/.local/bin/jq

jq: | ${HOME}/.local/bin/jq

clean_jq:
	rm ${HOME}/.local/bin/jq

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

clean_fzf:
	rm ${HOME}/.local/bin/fzf

#
## lldb
#

lldb: | ${HOME}/.lldbinit
	@echo "LLDB configuration installed"

${HOME}/.lldbinit:
	cp ${BASE_DIR}/lldb/lldbinit ${HOME}/.lldbinit

clean_lldb:
	rm ${HOME}/.lldbinit

#
## neovim
#

nvim: | ${HOME}/.config/nvim
	@echo "NeoVim configuration installed"

${HOME}/.config/nvim: ${HOME}/.config
	cp -r ${BASE_DIR}/nvim ${HOME}/.config/nvim

clean_nvim:
	rm -r ${HOME}/.config/nvim

#
## vim
#

vim: ${BASE_DIR}/vim/vimrc | ${HOME}/.vim
	ln -s ${BASE_DIR}/vim/vimrc ${HOME}/.vimrc

${HOME}/.vim:
	ln -s ${BASE_DIR}/vim ${HOME}/.vim

clean_vim:
	rm ${HOME}/.vim

#
## Rofi
#

rofi: | ${HOME}/.config/rofi
	@echo "Rofi configuration installed"

${HOME}/.config/rofi: ${HOME}/.config
	ln -s ${BASE_DIR}/rofi ${HOME}/.config/rofi

clean_rofi:
	rm ${HOME}/.config/rofi

#
## Tmux
#

tmux: ${HOME}/.tmux.conf ${HOME}/.config/tmux/session/dev-session

${HOME}/.tmux.conf: ${BASE_DIR}/tmux/tmux.conf
	cp ${BASE_DIR}/tmux/tmux.conf ${HOME}/.tmux.conf

${HOME}/.config/tmux: ${HOME}/.config/tmux/session/dev-session

${HOME}/.config/tmux/session/dev-session: ${BASE_DIR}/tmux/session/dev-session
	mkdir -p ${HOME}/.config/tmux/session
	cp ${BASE_DIR}/tmux/session/dev-session ${HOME}/.config/tmux/session/dev-session

clean_tmux:
	rm ${HOME}/.tmux.conf
	rm -f ${HOME}/.config/tmux/session/dev-session

#
## Zsh
#

ZSH_CONF_FILES := $(subst ${BASE_DIR}/zsh,${HOME}/.config/zsh,$(wildcard ${BASE_DIR}/zsh/*.zsh) $(wildcard ${BASE_DIR}/zsh/completions/*))

$(ZSH_CONF_FILES): | ${HOME}/.config/zsh/completions

${HOME}/.config/zsh/%: ${BASE_DIR}/zsh/%
	cp $< $@

${HOME}/.config/zsh/completions:
	mkdir -p ${HOME}/.config/zsh/completions

zsh: ${HOME}/.zshrc $(ZSH_CONF_FILES)

${HOME}/.zshrc: ${BASE_DIR}/zsh/zshrc
	cp ${BASE_DIR}/zsh/zshrc ${HOME}/.zshrc

zsh_Darwin: ${BASE_DIR}/.stamps/zsh_Darwin-stamp

${BASE_DIR}/.stamps/zsh_Darwin-stamp: ${BASE_DIR}/.stamps
	bash ${BASE_DIR}/platform/macos/defaults.sh
	touch ${BASE_DIR}/.stamps/zsh_Darwin-stamp

clean_zsh:
	rm -f ${HOME}/.zshrc
	rm -f $(ZSH_CONF_FILES)
	rm -fr ${HOME}/.config/zsh/completions

### Zsh plugins

zsh_plugins: ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting

${HOME}/.config/zsh/plugins:
	mkdir -p ${HOME}/.config/zsh/plugins

${HOME}/.config/zsh/plugins/zsh-syntax-highlighting:
	curl -L https://github.com/zsh-users/zsh-syntax-highlighting/archive/refs/tags/0.8.0.tar.gz -o ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting.tar.gz
	tar -xf ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting.tar.gz -C ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting --strip-components=1

#
## Alacritty
#
alacritty: ${HOME}/.config/alacritty/alacritty.toml

${HOME}/.config/alacritty/alacritty.toml: ${BASE_DIR}/terminals/alacritty/alacritty.toml
	mkdir -p ${HOME}/.config/alacritty
	cp ${BASE_DIR}/terminals/alacritty/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

#
# Directories
#

${BASE_DIR}/.stamps:
	mkdir -p ${BASE_DIR}/.stamps

clean_stamps:
	rm -r ${BASE_DIR}/.stamps

clean: clean_${SYSTEM} clean_stamps

clean_Darwin: clean_git clean_lldb clean_nvim clean_tmux clean_zsh

clean_Linux: clean_git clean_i3 clean_lldb clean_nvim clean_rofi clean_tmux clean_zsh

clean_FreeBSD: clean_git clean_lldb clean_nvim clean_tmux clean_zsh
