#!/bin/sh

if [ "x$(hostname)" = "xgossamer" ]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --auto
    xrandr --dpi 96
fi

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

# Multimedia
if [ "x$(hostname)" != "xtaz" ]; then
    playerctld daemon
fi

if [ "x$USER" = "xnonfreegaming" ]; then
    # Steam
    steam -silent &
    # xlunch
    xlunch --config "$HOME/.config/xlunch/xlunch.conf" &
else
    # File synchronization
    if [ "x$(hostname)" != "xtaz" ]; then
        syncthing -no-browser -no-restart & > /dev/null 2>&1
    fi

    # Lock
    xautolock -time 1 -locker 'sxlock -l' -notify 10 -notifier '/usr/bin/notify-send "Inactivity detected" -t 2000 -i /usr/share/icons/oxygen/base/128x128/actions/system-lock-screen.png' &

    # SSH agent
    eval $(ssh-agent)
fi

# Mozilla cache in RAM
if ! test -e "$HOME/.cache/mozilla" && ! test -h "$HOME/.cache/mozilla"; then
    ln -s "/tmp/.mozilla-cache_$USER" "$HOME/.cache/mozilla"
fi
if test -h "$HOME/.cache/mozilla"; then
    if ! test -e "/tmp/.mozilla-cache_$USER"; then
        mkdir -p -m 700  "/tmp/.mozilla-cache_$USER"
    elif ! test -O "/tmp/.mozilla-cache_$USER"; then
        echo "Security error: /tmp/.mozilla-cache_$USER does not belong to current user" >& 2
        exit 1
    fi
fi

# Window manager
exec awesome
