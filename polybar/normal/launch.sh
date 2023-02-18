#! /bin/sh

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

polybar --reload -q main -c "${HOME}/.config/polybar/config.ini" &
polybar --reload -q opt -c "${HOME}/.config/polybar/config.ini" &

polybar --reload -q tray -c "${HOME}/.config/polybar/config.ini" &

while [[ $(pgrep -x polybar | wc -l) -lt 3 ]]; do sleep 1; done
sleep 2

while [ -z "$(bspc query -N -n any.fullscreen)" ]; do sleep 1; done
sleep 2

TRAYBAR=$(pgrep -x polybar | tail -n 1)
xdo above -t $(bspc query -N -n any.fullscreen) $(xdo id -p ${TRAYBAR})
