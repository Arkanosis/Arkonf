#! /bin/sh

# TODO write a better canonize using sed loops; check that there is not remaining "/./" in the canonized path
installPath=`pwd`/`dirname $0`
while echo $installPath | grep '\.\.' > /dev/null; do
    installPath=`echo $installPath | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done

install()
{
    ( test -h "$2" || test -e "$2" ) && printf "\033[31m$2 already exist, skipped\033[0m\n" || ( ln -s "$installPath/$1" "$2" && printf "\033[32m$2 succefully installed\033[0m\n" )
}

install kde/kwinrc ~/.kde/share/config/kwinrc
install kde/user-places.xbel ~/.local/share/user-places.xbel
install yakuake/yakuakerc ~/.kde/share/config/yakuakerc

if ! ( test -h ~/.pydistutils.cfg || test -e ~/.pydistutils.cfg ); then
    install python/.pydistutils.cfg ~/.pydistutils.cfg
    sed -i "s@^prefix=.*@prefix=$HOME/local@" ~/.pydistutils.cfg
fi

if ! ( test -h ~/.config.site || test -e ~/.config.site ); then
    install autoconf/.config.site ~/.config.site
    arch=`uname -sm | tr ' ' '-'`
    echo "prefix=$HOME/local_$arch" >> ~/.config.site
fi
