# bspwm-setup
The polybar setup was written by
[Fleckenstein](https://github.com/EliasFleckenstein03).
It is edited to display a second bar on an external monitor.

## install.sh
The `install.sh` script installs the entire setup:
- bspwm
- xorg
- polybar
- scrot
- feh
- picom
- dunst
- lua5.3
- vlc
- firefox-esr (because regular firefox isn't in debian apt repos)
- thunderbird
- signal-desktop
- fonts-hack
- fonts-noto-color-emoji
- xclip
- hexchat

It then symlinks the configuration files for those packages
to the files in this repository. This has two advantages.
First, I can easily make changes and don't have to copy configs
into the repo. On top of this the configs can easily be updated
by running `git pull`.

After that `shell_only.sh` is started.

## shell_only.sh
The `shell_only.sh` script installs zsh with a custom theme
and some utilities:
- bat
- lolcat
- cowsay
- fortune
- zsh
- git
- figlet
- curl
- wget
- htop
- tty-clock
- oathtool
- bc
- units
- tmux
- vim

Just like `install.sh` this script symlinks the configuration files.
You can run this instead of install.sh to install the shell setup
on headless servers, or if you don't want to use the rest of the setup.

## Keybinds / Controls
### sxhkd
The sxhkd keybinds are well documented in `sxhkdrc`.

### Vim
#### Normal mode
- `Enter`: Insert new line above current line

### tmux
#### Prefix: ctrl + s
- `x`: Display panes
- `q`: Kill pane
- `shift + h`: Horizontal split
- `shift + v`: Vertical split
- `+`: New window
- `c`: Enter copy mode
- `v`: Paste
