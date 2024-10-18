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
	${SUDO} pacman -Sy --noconfirm --ask 4 --needed \
		river \
		seatd-openrc \
		alacritty \
		wofi \
		waybar \
		waylock \
		swaybg \
		swayidle \
		feh \
		wl-clipboard \
		libnotify \
		vlc \
		firefox \
		qutebrowser \
		aerc \
		mbsync \
		moreutils \
		cronie-openrc \
		signal-desktop \
		element-desktop \
		kwayland5 \
		fontconfig \
		terminus-font \
		ttf-hack \
		noto-fonts \
		noto-fonts-emoji \
		noto-fonts-extra \
		ttf-dejavu \
		brightnessctl \
		pipewire \
		pipewire-alsa \
		pipewire-pulse \
		wireplumber \
		alsa-utils \
		xdg-desktop-portal \
		xdg-desktop-portal-wlr \
		xdg-user-dirs \
		gstreamer \
		gst-plugins-base \
		gst-plugins-good \
		gst-plugins-bad \
		zathura

	paru -Sy --noconfirm --needed \
		river-bsp-layout \
		grim \
		slurp \
		wired \
		wlopm-git

	${SUDO} rc-update add seatd boot
	${SUDO} rc-service seatd start
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

xdg-mime default feh.desktop image/jpeg
xdg-mime default feh.desktop image/png
xdg-mime default org.pwmt.zathura.desktop application/pdf

mkdir -p ~/.config/alacritty
ln -sf ${PWD}/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.gnupg
ln -sf ${PWD}/gpg-agent.conf ~/.gnupg/gpg-agent.conf

mkdir -p ~/.config/wired
ln -sf ${PWD}/wired.ron ~/.config/wired/wired.ron

mkdir -p ~/.config/aerc
ln -sf ${PWD}/aerc.conf ~/.config/aerc/aerc.conf

cargo install --git https://github.com/HimbeerserverDE/musikbox.git

chsh -s /bin/zsh

echo -e "\e[1m\e[1;32mSuccess! You can now log in on tty1."
echo -e "\e[1m\e[1;32mYou can set the keyboard layout in the ~/.kblayout file."
echo -en "\e[0m"
