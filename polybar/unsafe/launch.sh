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

SCR1=$(xrandr -q | grep ' connected' | grep primary | awk '{print $1}')

cp -p ${HOME}/.config/polybar/template.ini ${HOME}/.config/polybar/config.ini
sed -i "s/SCR1/${SCR1}/g" ${HOME}/.config/polybar/config.ini

polybar --reload -q main -c "${HOME}/.config/polybar/config.ini" &

${HOME}/.config/polybar/scr2.sh &
${HOME}/.config/polybar/tray.sh &
