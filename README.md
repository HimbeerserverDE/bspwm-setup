# bspwm-setup
## Software
The software the scripts install depends on your distro.
I don't maintain a seperate list in the README anymore,
but you can look at the scripts yourself (you should already be doing this).

bspwm will attempt to load the keyboard layout in `~/.xkeymap`.
To set it, run `echo LAYOUT > ~/.xkeymap` where `LAYOUT` is
the lower case two character code (e.g. `us` or `de`).

## install.sh
The `install.sh` script installs the entire setup.

It then symlinks the configuration files for those packages
to the files in this repository. This has two advantages.
First, I can easily make changes and don't have to copy configs
into the repo. On top of this the configs can easily be updated
by running `git pull`.

After that `shell_only.sh` is started.

## shell_only.sh
The `shell_only.sh` script installs zsh with a custom theme
and some utilities.

Just like `install.sh` this script symlinks the configuration files.
You can run this instead of install.sh to install the shell setup
on headless servers, or if you don't want to use the rest of the setup.

## Starting a X session
By default this setup launches X when zsh is started on tty1.
You can however use a display manager if you want.

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
