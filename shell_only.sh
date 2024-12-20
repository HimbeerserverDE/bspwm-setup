#! /bin/bash

# Copyright (C) 2022  HimbeerserverDE
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

function called_directly {
	[[ ${SHLVL} -eq 2 ]]
}

if called_directly; then
	echo -e "\e[1m\e[1;31mMAKE SURE YOU ARE IN THE DIRECTORY THIS SCRIPT IS LOCATED IN!"
	echo -e "\e[0m\e[1;31mIf you're sure you are in the correct dir, press Enter."
	read
	echo -e "\e[0m"
fi

function command_exists {
	command -v $1 &> /dev/null
}

if [ ${UID} -ne 0 ]; then
	if command_exists doas; then
		SUDO="doas"
	elif command_exists sudo; then
		SUDO="sudo"
	else
		echo "Requires doas or sudo to be installed."
		exit 1
	fi
fi

if command_exists pacman; then
	${SUDO} sed -i "s/#PACMAN_AUTH=()/PACMAN_AUTH=(${SUDO})/" /etc/makepkg.conf

	${SUDO} pacman -Sy --noconfirm --needed \
		bat \
		zsh \
		git \
		curl \
		wget \
		bc \
		tmux \
		vim \
		fzf \
		openssh \
		which \
		gcc \
		pkg-config \
		openssl \
		fakeroot \
		make \
		automake \
		autoconf \
		m4 \
		rustup \
		gping \
		htop

	rustup default stable

	rm -rf /tmp/paru
	(cd /tmp && git clone https://aur.archlinux.org/paru.git)
	(cd /tmp/paru && makepkg -si)

	mkdir -p ~/.config/paru/
	cat <<EOT > ~/.config/paru/paru.conf
[bin]
Sudo = $(which ${SUDO})
EOT

	paru -S --noconfirm --needed \
		insect
elif command_exists apt; then
	${SUDO} apt update
	${SUDO} apt install -y \
		bat \
		zsh \
		git \
		curl \
		wget \
		bc \
		units \
		tmux \
		vim \
		fzf \
		openssh-client \
		rust-all \
		htop

	cargo install cargo-update gping
else
	echo "Your distro is not supported."
	exit 1
fi

ln -sf ${PWD}/bin ~/bin

mkdir -p ~
ln -sf ${PWD}/zshrc ~/.zshrc
ln -sf ${PWD}/zsh_aliases ~/.zsh_aliases
ln -sf ${PWD}/himbeer.zsh ~/.zshtheme.zsh
ln -sf ${PWD}/fzf_key_bindings.zsh ~/.zsh_fzf_key_bindings
ln -sf ${PWD}/fzf_completion.zsh ~/.zsh_fzf_completion

mkdir -p ~/.zprompts
ln -sf ${PWD}/himbeer.zsh ~/.zprompts/prompt_himbeer_setup

mkdir -p ~/.zplugins
ln -sf ${PWD}/git.zsh ~/.zplugins/00_git.zsh
ln -sf ${PWD}/git.plugin.zsh ~/.zplugins/git.plugin.zsh

ln -sf ${PWD}/tmux.conf ~/.tmux.conf
ln -sf ${PWD}/vimrc ~/.vimrc

if called_directly; then
	echo -e "\e[1m\e[1;32mShell setup has been successfully installed!"
	echo -e "\e[1m\e[1;32mIf you wish to make zsh your default shell:"
	echo -e "\e[1m\e[1;32m	# usermod -s /bin/zsh ${USER}"
	echo -e "\e[1m\e[1;32mOR:"
	echo -e "\e[1m\e[1;32m	$ chsh -s /bin/zsh"
	echo -en "\e[0m"
fi
