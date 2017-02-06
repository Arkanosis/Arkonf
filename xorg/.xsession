#!/bin/sh

# Env
export ARKONF_DIR="/udir/jroquet/Arkonf"
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
export PATH="/udir/jroquet/local_Linux-x86_64/bin:/udir/jroquet/local/bin:$PATH"

# Keyboard
setxkbmap us
xmodmap ~/.Xmodmap
xset r 66

# Daemons
emacs --daemon=emacsconsole &

if type gnome-keyring-daemon >/dev/null 2>&1; then
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets)
    export GNOME_KEYRING_CONTROL
    export GNOME_KEYRING_PID
    export GPG_AGENT_INFO
fi
if type ssh-agent >/dev/null 2>&1; then
    eval $(ssh-agent)
fi

# Programs
#firefox &!
#thunderbird &!
#pidgin &!

# Kill useless daemons
killall ibus-daemon

# Window manager
exec /usr/bin/awesome
