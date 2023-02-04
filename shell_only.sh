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

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo '. "$HOME/.cargo/env"' >> ~/.zshenv
source ~/.cargo/env

if command_exists pacman; then
	${SUDO} pacman -Sy --noconfirm --needed \
		bat \
		cowsay \
		fortune-mod \
		zsh \
		git \
		figlet \
		curl \
		wget \
		htop \
		bc \
		units \
		tmux \
		vim \
		neofetch \
		fzf \
		openssh \
		ripgrep

	cargo install paru

	mkdir -p ~/.config/paru/
	cat <<EOT > ~/.config/paru/paru.conf
[bin]
Sudo = $(which ${SUDO})
EOT

	paru -S --noconfirm tty-clock-git
elif command_exists apt; then
	${SUDO} apt update
	${SUDO} apt install -y \
		bat \
		cowsay \
		fortune \
		zsh \
		git \
		figlet \
		curl \
		wget \
		htop \
		tty-clock \
		bc \
		units \
		tmux \
		vim \
		neofetch \
		fzf \
		openssh-client
else
	echo "Your distro is not supported."
	exit 1
fi

cargo install cargo-update gping lcat

rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ln -sf ${PWD}/bin ~/bin

mkdir -p ~/
ln -sf ${PWD}/zshrc ~/.zshrc
ln -sf ${PWD}/zsh_aliases ~/.zsh_aliases
ln -sf ${PWD}/fzf_key_bindings.zsh ~/.zsh_fzf_key_bindings
ln -sf ${PWD}/fzf_completion.zsh ~/.zsh_fzf_completion
ln -sf ${PWD}/tmux.conf ~/.tmux.conf
ln -sf ${PWD}/vimrc ~/.vimrc

mkdir -p ~/.oh-my-zsh/
ln -sf ${PWD}/himbeer.zsh-theme ~/.oh-my-zsh/themes/himbeer.zsh-theme

if called_directly; then
	echo -e "\e[1m\e[1;32mShell setup has been successfully installed!"
	echo -e "\e[1m\e[1;32mIf you wish to make zsh your default shell:"
	echo -e "\e[1m\e[1;32m	# usermod -s /bin/zsh ${USER}"
	echo -e "\e[1m\e[1;32mOR:"
	echo -e "\e[1m\e[1;32m	$ chsh -s /bin/zsh"
	echo -en "\e[0m"
fi
