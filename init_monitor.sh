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

SCR1=$(xrandr -q | grep ' connected' | grep primary | awk '{print $1}')

while [ true ]; do
	SCR2=$(xrandr -q | grep ' connected' | grep -v primary | awk '{print $1}')

	if [ "$(xrandr -q | grep "${SCR2}" | awk '{print $2}')" == "connected" ]; then
		xrandr --output "${SCR2}" --auto
		xrandr --output "${SCR2}" --right-of "${SCR1}"

		sleep 1

		bspc monitor "${SCR2}" -n 2 -d 1 2 3 4 5 6 7 8 9

		MODE=$(readlink ~/.config/polybar | sed 's/\//\n/g' | tail -n 1)
		if [ "${MODE}" == "normal" ]; then
			BG="wallpaper"
		elif [ "${MODE}" == "unsafe" ]; then
			BG="unsafe_wallpaper"
		fi

		feh --no-fehbg --bg-fill "${HOME}/.config/bspwm/${BG}"

		exit 0
	fi

	sleep 10
done
