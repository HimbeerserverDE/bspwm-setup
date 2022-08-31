#!/bin/bash

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
	$SUDO apt update
	$SUDO apt install -y \
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
		vim
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

mkdir -p ~/
ln -s ${PWD}/zsh_aliases ~/.zsh_aliases

mkdir -p ~/
ln -s ${PWD}/vimrc ~/.vimrc

mkdir -p ~/.local/bspwm-setup/
ln -s ${PWD}/lockscreen.xkb ~/.local/bspwm-setup/lockscreen.xkb

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
