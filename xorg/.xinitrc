#!/bin/sh

# Env
export ARKONF_DIR="$HOME/Arkonf"
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Resources
xrdb -merge "$HOME/.Xresources"

# Keyboard
setxkbmap us
xmodmap "$HOME/.Xmodmap"
xset r 66

# Touchpad
syndaemon -t -K -R -i .5 -d

# Daemons
emacs --daemon=emacsconsole &

# Lock
xautolock -time 1 -locker 'sxlock -l' &

# SSH agent
eval $(ssh-agent)

# Mozilla cache in RAM
if ! test -e "$HOME/.cache/mozilla" && ! test -h "$HOME/.cache/mozilla"; then
    ln -s "/tmp/.mozilla-cache_$USER" "$HOME/.cache/mozilla"
fi
if test -h "$HOME/.cache/mozilla"; then
    if ! test -e "/tmp/.mozilla-cache_$USER"; then
	mkdir -p -m 700  "/tmp/.mozilla-cache_$USER"
    elif ! test -o "/tmp/.mozilla-cache_$USER"; then
	echo "Security error: /tmp/.mozilla-cache_$USER does not belong to current user" >& 2
	exit 1
    fi
fi

# Window manager
exec awesome
