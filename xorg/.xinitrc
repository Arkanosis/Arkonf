#!/bin/sh

# Env
export ARKONF_DIR=~/Arkonf
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8

# Resources
xrdb -merge ~/.Xresources

# Keyboard
setxkbmap us
xmodmap ~/.Xmodmap
xset r 66

# Touchpad
syndaemon -t -K -R -i .5 -d

# Daemons
emacs --daemon=emacsconsole &

# Lock
xautolock -time 1 -locker 'sxlock -l' &

# SSH agent
eval $(ssh-agent)

# Window manager
exec awesome