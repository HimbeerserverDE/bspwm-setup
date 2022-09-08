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

echo -e "\e[1m\e[1;31mMAKE SURE YOU ARE IN THE DIRECTORY THIS SCRIPT IS LOCATED IN!"
echo -e "\e[0m\e[1;31mIf you're sure you are in the correct dir, press Enter."
read
echo -e "\e[0m"

./shell_only.sh
source ~/.cargo/env

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
	${SUDO} pacman -Sy --noconfirm --needed \
		bspwm \
		sxhkd \
		xorg \
		xorg-xinit \
		rofi \
		polybar \
		scrot \
		feh \
		picom \
		dunst \
		libnotify \
		lua53 \
		vlc \
		firefox \
		thunderbird \
		signal-desktop \
		terminus-font \
		ttf-hack \
		noto-fonts \
		noto-fonts-emoji \
		xclip \
		hexchat \
		brightnessctl \
		pulseaudio

	bin/aurinstall --noconfirm cava
	bin/aurinstall --noconfirm i3lock-fancy-rapid-git
elif command_exists apt; then
	${SUDO} apt install -y gnupg gcc cmake g++ pkg-config libfontconfig1-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev

	wget -O- https://updates.signal.org/desktop/apt/keys.asc | ${SUDO} apt-key add -
	echo "deb [arch=$(dpkg --print-architecture)] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list

	${SUDO} apt update
	${SUDO} apt install --no-install-recommends -y \
		bspwm \
		sxhkd \
		xorg \
		rofi \
		polybar \
		scrot \
		feh \
		picom \
		dunst \
		lua5.3 \
		vlc \
		firefox-esr \
		thunderbird \
		signal-desktop \
		fonts-terminus \
		fonts-hack \
		fonts-noto \
		fonts-noto-color-emoji \
		xclip \
		hexchat \
		brightnessctl \
		cava \
		pulseaudio
else
	echo "Your distro is not supported."
	exit 1
fi

mkdir -p ~/.config/bspwm
ln -sf ${PWD}/bspwmrc ~/.config/bspwm/bspwmrc
ln -sf ${PWD}/init_monitor.sh ~/.config/bspwm/init_monitor.sh

mkdir -p ~/.config/sxhkd
ln -sf ${PWD}/sxhkdrc ~/.config/sxhkd/sxhkdrc

mkdir -p ~/.config/rofi
ln -sf ${PWD}/rofi_config ~/.config/rofi/config
ln -sf ${PWD}/rofi_config.rasi ~/.config/rofi/config.rasi

ln -sf ${PWD}/polybar ~/.config/polybar

mkdir -p ~/.config
ln -sf ${PWD}/picom.conf ~/.config/picom.conf

${SUDO} usermod -aG video ${USER}

cargo install alacritty

mkdir -p ~/.config/alacritty
ln -sf ${PWD}/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/
ln -sf ${PWD}/xinitrc ~/.xinitrc

echo -e "\e[1m\e[1;32mSuccess! You can now log in using your preferred DM."
echo -e "\e[1m\e[1;32mIf you wish to make zsh your default shell:"
echo -e "\e[1m\e[1;32m	# usermod -s /bin/zsh ${USER}"
echo -e "\e[1m\e[1;32mOR:"
echo -e "\e[1m\e[1;32m	$ chsh -s /bin/zsh"
