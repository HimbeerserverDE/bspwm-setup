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
		figlet
else
	echo "Your distro is not supported."
	exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s ${PWD}/bin ~/bin

mkdir -p ~/.oh-my-zsh/themes
ln -s ${PWD}/himbeer.zsh-theme ~/.oh-my-zsh/themes/himbeer.zsh-theme

mkdir -p ~/
ln -s ${PWD}/zshrc ~/.zshrc
