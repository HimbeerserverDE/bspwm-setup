#! /bin/bash

while [ true ]; do
	if [ "$(xrandr -q | grep 'DP-2' | awk '{print $2}')" == "connected" ]; then
		xrandr --output 'DP-2' --right-of 'eDP-1'
		bspc monitor 'DP-2' -n 2 -d 1 2 3 4 5 6 7 8 9
		bspc wm -r
		exit 0
	fi

	sleep 10
done
