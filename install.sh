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

if [[ -z "$1" || -z "$2" ]]; then
	echo -e "\e[1m\e[1;31mUsage: <xkblayout> <xkbvariant>"
	exit 1
fi

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
		river \
		seatd-openrc \
		wofi \
		waybar \
		waylock \
		swaybg \
		swayidle \
		libnotify \
		vlc \
		firefox \
		thunderbird \
		signal-desktop \
		element-desktop \
		fontconfig \
		terminus-font \
		ttf-hack \
		ttf-hanazono \
		noto-fonts \
		noto-fonts-emoji \
		noto-fonts-extra \
		ttf-dejavu \
		hexchat \
		brightnessctl \
		pipewire \
		pipewire-alsa \
		pipewire-pulse \
		wireplumber \
		alsa-utils \
		xdg-desktop-portal-wlr \
		xdg-user-dirs \
		gstreamer \
		gst-plugins-base \
		gst-plugins-good \
		gst-plugins-bad \
		sl

	paru -S --noconfirm cava neo-matrix wired wlopm

	${SUDO} pacman -Rndd polkit

	${SUDO} rc-update add seatd boot
else
	echo "Your distro is not supported."
	exit 1
fi

mkdir -p ~/.config/river
ln -sf ${PWD}/riverrc ~/.config/river/init

ln -sf ${PWD}/waybar ~/.config/waybar

mkdir -p ~/.config/wofi
ln -sf ${PWD}/wofi.css ~/.config/wofi/style.css

mkdir -p ~/.config/fontconfig
ln -sf ${PWD}/fonts.conf ~/.config/fontconfig/fonts.conf

${SUDO} usermod -aG seat ${USER}
${SUDO} usermod -aG video ${USER}

xdg-user-dirs-update --set DESKTOP ~
xdg-user-dirs-update --set DOWNLOAD ~/downloads
xdg-user-dirs-update --set TEMPLATES ~
xdg-user-dirs-update --set PUBLICSHARE ~
xdg-user-dirs-update --set DOCUMENTS ~/documents
xdg-user-dirs-update --set MUSIC ~/music
xdg-user-dirs-update --set PICTURES ~/pictures
xdg-user-dirs-update --set VIDEOS ~/videos

cargo install alacritty
cargo install river-bsp-layout

mkdir -p ~/.config/alacritty
ln -sf ${PWD}/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.gnupg
ln -sf ${PWD}/gpg-agent.conf ~/.gnupg/gpg-agent.conf

mkdir -p ~/.config/cava
ln -sf ${PWD}/cava_config ~/.config/cava/config

mkdir -p ~/.config/wired
ln -sf ${PWD}/wired.ron ~/.config/wired/wired.ron

cargo install --git https://github.com/HimbeerserverDE/musikbox.git

chsh -s /bin/zsh

echo -e "\e[1m\e[1;32mSuccess! You can now log in on tty1."
echo -en "\e[0m"
