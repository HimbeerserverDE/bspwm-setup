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
		xdo \
		rofi \
		polybar \
		flameshot \
		feh \
		picom \
		dunst \
		libnotify \
		vlc \
		firefox \
		thunderbird \
		signal-desktop \
		element-desktop \
		terminus-font \
		ttf-hack \
		ttf-hanazono \
		noto-fonts \
		noto-fonts-emoji \
		noto-fonts-extra \
		xclip \
		hexchat \
		brightnessctl \
		pipewire \
		pipewire-alsa \
		pipewire-pulse \
		wireplumber \
		alsa-utils \
		chafa \
		xdg-user-dirs \
		xss-lock

	paru -S --noconfirm cava i3lock-fancy-rapid-git neo-matrix
elif command_exists apt; then
	${SUDO} apt install -y gnupg gcc cmake g++ pkg-config libfontconfig1-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev apt-transport-https

	wget -O- https://updates.signal.org/desktop/apt/keys.asc | ${SUDO} apt-key add -
	echo "deb [arch=$(dpkg --print-architecture)] https://updates.signal.org/desktop/apt xenial main" | ${SUDO} tee /etc/apt/sources.list.d/signal-xenial.list

	${SUDO} wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
	echo "deb [signey-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/default main" | ${SUDO} tee /etc/apt/sources.list.d/element-io.list

	${SUDO} apt update
	${SUDO} apt install --no-install-recommends -y \
		bspwm \
		sxhkd \
		xorg \
		xdo \
		rofi \
		polybar \
		flameshot \
		feh \
		picom \
		dunst \
		vlc \
		firefox-esr \
		thunderbird \
		signal-desktop \
		element-desktop \
		fonts-terminus-otb \
		fonts-hack \
		fonts-hanazono \
		fonts-noto \
		fonts-noto-color-emoji \
		xclip \
		hexchat \
		brightnessctl \
		cava \
		pipewire \
		pipewire-bin \
		wireplumber \
		alsa-utils \
		chafa \
		xdg-user-dirs \
		xss-lock
else
	echo "Your distro is not supported."
	exit 1
fi

mkdir -p ~/.config/bspwm
ln -sf ${PWD}/bspwmrc ~/.config/bspwm/bspwmrc
ln -sf ${PWD}/init_monitor.sh ~/.config/bspwm/init_monitor.sh
ln -sf ${PWD}/intro.canvas ~/.config/bspwm/intro.canvas
ln -sf ${PWD}/intro.rules ~/.config/bspwm/intro.rules

find ${PWD} -name "intro_*.canvas" | xargs ln -sf -t ~/.config/bspwm/
find ${PWD} -name "intro_*.rules" | xargs ln -sf -t ~/.config/bspwm/

mkdir -p ~/.config/sxhkd
ln -sf ${PWD}/sxhkdrc ~/.config/sxhkd/sxhkdrc

mkdir -p ~/.config/rofi
ln -sf ${PWD}/rofi_config ~/.config/rofi/config
ln -sf ${PWD}/rofi_config.rasi ~/.config/rofi/config.rasi

# not the actual config location, it will be symlinked by the mode switch
ln -sf ${PWD}/polybar ~/.config/polybar.d

mkdir -p ~/.config
ln -sf ${PWD}/picom.conf ~/.config/picom.conf

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

mkdir -p ~/.config/alacritty
ln -sf ${PWD}/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/
ln -sf ${PWD}/xinitrc ~/.xinitrc

mkdir -p ~/.gnupg
ln -sf ${PWD}/gpg-agent.conf ~/.gnupg/gpg-agent.conf

cargo install --git https://github.com/HimbeerserverDE/musikbox.git

chsh -s /bin/zsh

echo -e "\e[1m\e[1;32mSuccess! You can now log in on tty1."
echo -en "\e[0m"
