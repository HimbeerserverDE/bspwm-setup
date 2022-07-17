#! /bin/bash

while [ true ]; do
	if [ -n "$(xrandr --listmonitors | grep 'DP-2')" ]; then
		bspc monitor 'DP-2' -n 2 -d 1 2 3 4 5 6 7 8 9
		exit 0
	fi

	sleep 10
done
