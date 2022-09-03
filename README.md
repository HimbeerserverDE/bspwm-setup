# bspwm-setup
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
Pretty much all you need to do is start bspwm in your `~/.xinitrc`
and maybe set the keyboard layout. Then just startx from text mode.
You can automate startx in your shell rc.

Alternatively you can use a display manager of your choice.

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
