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
