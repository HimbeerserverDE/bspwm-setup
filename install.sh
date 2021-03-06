#!/bin/bash

echo -e "\e[1m\e[1;31mMAKE SURE YOU ARE IN THE DIRECTORY THIS SCRIPT IS LOCATED IN!"
echo -e "\e[0m\e[1;31mIf you're sure you are in the correct dir, press Enter."
read
echo -e "\e[0m"

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
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | $SUDO apt-key add -
	echo "deb [arch=$(dpkg --print-architecture)] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

	$SUDO apt update
	$SUDO apt install -y \
		bspwm \
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
		signal-desktop
	$SUDO apt purge -y \
		lemonbar # automatically installed but unwanted
else
	echo "Your distro is not supported."
	exit 1
fi

mkdir -p ~/.config/bspwm
ln -s ${PWD}/bspwmrc ~/.config/bspwm/bspwmrc
ln -s ${PWD}/wait_for_monitor.sh ~/.config/bspwm/wait_for_monitor.sh

mkdir -p ~/.config/sxhkd
ln -s ${PWD}/sxhkdrc ~/.config/sxhkd/sxhkdrc

mkdir -p ~/.config/rofi
ln -s ${PWD}/rofi_config ~/.config/rofi/config

mkdir -p ~/.config/polybar
ln -s ${PWD}/polybar ~/.config/polybar

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | bash

ln -s ${PWD}/kitty/ ~/.config/kitty

mkdir -p ~/.config
ln -s ${PWD}/picom.conf ~/.config/picom.conf

./shell_only.sh
