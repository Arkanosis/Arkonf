#!/bin/sh

xrdb -merge $HOME/.Xresources
xmodmap $HOME/.Xmodmap

exec awesome
