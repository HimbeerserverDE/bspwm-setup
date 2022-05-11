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
		wget
else
	echo "Your distro is not supported."
	exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s ${PWD}/bin ~/bin

mkdir -p ~/
ln -s ${PWD}/zshrc ~/.zshrc

mkdir -p ~/
ln -s ${PWD}/zsh_aliases ~/.zsh_aliases

sudo mkdir -p /usr/local/bin
cd /usr/local/bin
curl https://getmic.ro/r | $SUDO sh
$SUDO update-alternatives --set editor /usr/local/bin/micro
