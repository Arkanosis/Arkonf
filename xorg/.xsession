#!/bin/sh

# Env
export ARKONF_DIR="/udir/jroquet/Arkonf"
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
export PATH="/udir/jroquet/.local_Linux-x86_64/bin:/udir/jroquet/.local/bin:$PATH"

# Resources
xrdb -merge "$HOME/.Xresources"

# Keyboard
setxkbmap us
xmodmap "$HOME/.Xmodmap"
xset r 66

# Lock
xautolock -time 1 -locker 'gnome-screensaver-command --lock' -notify 10 -notifier '/usr/bin/notify-send "Inactivity detected" -t 2000 -i /usr/share/icons/oxygen/base/128x128/actions/system-lock-screen.png' &

# Keyring
if type gnome-keyring-daemon >/dev/null 2>&1; then
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets)
    export GNOME_KEYRING_CONTROL
    export GNOME_KEYRING_PID
    export GPG_AGENT_INFO
fi

# SSH agent
eval $(ssh-agent)

# Kill useless daemons
killall ibus-daemon

# Window manager
exec awesome
