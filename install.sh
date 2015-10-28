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

printf '\033[33mArkinstall v0.1\n'
printf '(C) 2009-2015 - Arkanosis\n'
printf 'jroquet@arkanosis.net\n'
printf 'Check for latest version at http://github.com/Arkanosis/Arkonf\033[0m\n'

echo

install dotfiles/.forward ~/.forward
install dotfiles/.pgpkey ~/.pgpkey
install dotfiles/.plan ~/.plan
install dotfiles/.project ~/.project
install dotfiles/.signature ~/.signature

install zsh/.zshrc ~/.zshrc
install zsh/.zsh ~/.zsh

install mercurial/.hgrc ~/.hgrc
install git/.gitconfig ~/.gitconfig

install gtk/.gtkrc-2.0 ~/.gtkrc-2.0

install emacs/.emacs ~/.emacs
install emacs/.emacs.d ~/.emacs.d

install gdb/.gdbinit ~/.gdbinit

install python/.pythonrc.py ~/.pythonrc.py

install pywikibot/.pywikibot ~/.pywikibot

install pyjab/.pyjabrc ~/.pyjabrc
install weechat/.weechat ~/.weechat

install slrn/.slrnrc ~/.slrnrc

mkdir ~/.config/lxc
install lxc/default.conf ~/.config/lxc/default.conf

install ssh/.ssh/config ~/.ssh/config

install screen/.screenrc ~/.screenrc
install tmux/.tmux.conf ~/.tmux.conf

install uncrustify/.uncrustifyrc ~/.uncrustifyrc

install vim/.vimrc ~/.vimrc
install vim/.vim ~/.vim

install awesome ~/.config/awesome

install xorg/.Xmodmap ~/.Xmodmap
install xorg/.Xresources ~/.Xresources
install xorg/.Xresources ~/.Xdefaults

if ! ( test -h ~/.pydistutils.cfg || test -e ~/.pydistutils.cfg ); then
    install python/.pydistutils.cfg ~/.pydistutils.cfg
    sed -i "s@^prefix=.*@prefix=$HOME/local@" ~/.pydistutils.cfg
fi

if ! ( test -h ~/.config.site || test -e ~/.config.site ); then
    install autoconf/.config.site ~/.config.site
    arch=`uname -sm | tr ' ' '-'`
    echo "prefix=$HOME/local_$arch" >> ~/.config.site
fi

echo

echo 'Edit the configuration files? [yN]'
read y
if [ "$y" = 'Y' ] || [ "$y" = 'y' ]; then
    vi ~/.zshrc
    vi ~/.hgrc
    vi ~/.gitconfig
fi
