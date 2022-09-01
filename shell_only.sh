#!/bin/bash

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

function command_exists {
	command -v $1 &> /dev/null
}

set -x

if [ $UID -ne 0 ]; then
	if command_exists sudo; then
		SUDO="sudo"
	elif command_exists doas; then
		SUDO="doas"
	fi
fi

if command_exists apt; then
	${SUDO} apt update
	${SUDO} apt install -y \
		bat \
		lolcat \
		cowsay \
		fortune \
		zsh \
		git \
		figlet \
		curl \
		wget \
		htop \
		tty-clock \
		oathtool \
		bc \
		units \
		tmux \
		vim \
		neofetch
else
	echo "Your distro is not supported."
	exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s ${PWD}/bin ~/bin

rm ~/.zshrc
rm ~/.zsh_aliases

mkdir -p ~/
ln -s ${PWD}/zshrc ~/.zshrc
ln -s ${PWD}/zsh_aliases ~/.zsh_aliases
ln -s ${PWD}/tmux.conf ~/.tmux.conf
ln -s ${PWD}/vimrc ~/.vimrc

mkdir -p ~/.oh-my-zsh/completions/
ln -s ${PWD}/_totp ~/.oh-my-zsh/completions/_totp

mkdir -p ~/.local/bspwm-setup/
ln -s ${PWD}/lockscreen.xkb ~/.local/bspwm-setup/lockscreen.xkb

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
