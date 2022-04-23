#!/bin/sh

polybar --reload -q main -c "$HOME/.config/polybar/config.ini" &
polybar --reload -q opt -c "$HOME/.config/polybar/config.ini" &
