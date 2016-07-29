#!/bin/sh

xrdb -merge $HOME/.Xresources
xmodmap $HOME/.Xmodmap
syndaemon -t -K -R -i .5 -d

exec awesome
