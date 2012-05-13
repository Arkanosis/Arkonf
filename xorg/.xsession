# Keyboard
setxkbmap us
xmodmap ~/.Xmodmap
xset r 66

# Daemons
emacs --daemon=emacsconsole &

# Window manager
exec /usr/bin/awesome
