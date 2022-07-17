#!/bin/sh

polybar --reload -q main -c "$HOME/.config/polybar/config.ini" &
polybar --reload -q opt -c "$HOME/.config/polybar/config.ini" &

while [ -e "$(pgrep -x polybar)" ]; do sleep 1; done
sleep 2

POLYBARS=$(pgrep -x polybar)
for BAR in ${POLYBARS}; do
	xdo below -t $(xdo id -n root) $(xdo id -p ${BAR})
done
