# bspwm-setup

This used to be an actual bspwm environment but the repository is now being
used for my current setup regardless of what it's based on.
The current setup actually uses river which is a Wayland replacement for
bspwm.

## Software

The software the scripts install depends on your distro.
I don't maintain a separate list in the README anymore,
but you can look at the scripts yourself (you should already be doing this).

The keyboard layout needs to be written to `~/.kblayout`, e.g.

```
echo -n de > ~/.kblayout
```

## install.sh

The `install.sh` script installs the entire setup.

To do this, it first calls `shell_only.sh` and then does some additional stuff.

It then symlinks the configuration files for those packages
to the files in this repository. This has two advantages.
First, I can easily make changes and don't have to copy configs
into the repo. On top of this the configs can easily be updated
by running `git pull`.

## shell_only.sh

The `shell_only.sh` script installs zsh with a custom theme
and some utilities.

Just like `install.sh` this script symlinks the configuration files.
You can run this instead of install.sh to install the shell setup
on headless servers, or if you don't want to use the rest of the setup.

A full install is recommended.

## Starting a Wayland session

By default this setup launches river when zsh is started on tty1.
You can however use a display manager if you want.

## Keybinds / Controls

### river

The river keybinds are well documented in `riverrc`.

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
