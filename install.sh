#! /bin/sh

installPath=`pwd`/`dirname $0`
while echo $installPath | grep '\.\.' > /dev/null; do
    installPath=`echo $installPath | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done

install()
{
    test -e "$2" && printf "\033[31m$2 already exist, skipped\033[0m\n" || ( ln -s "$installPath/$1" "$2" && printf "\033[32m$2 succefully installed\033[0m\n" )
}

printf '\033[33mArkinstall v0.1\n'
printf '(C) 2009 - Arkanosis\n'
printf 'arkanosis@gmail.com\n'
printf 'Check for latest version at http://github.com/Arkanosis/Arkonf\033[0m\n'

echo

install zsh/.zshrc ~/.zshrc
install zsh/.zsh ~/.zsh

install mercurial/.hgrc ~/.hgrc
install git/.gitconfig ~/.gitconfig

install fluxbox ~/.fluxbox

install emacs/.emacs ~/.emacs
install emacs/.emacs.d ~/.emacs.d

install vim/.vimrc ~/.vimrc
<<<<<<< HEAD:install.sh
install xmonad ~/.xmonad
=======
install vim/.vim ~/.vim

>>>>>>> 7321acf14d1cc0131f8be1813dc2525a5ccec24d:install.sh
install xorg/.Xmodmap ~/.Xmodmap

echo

echo 'Edit the configuration files? [yN]'
read y
if [ "$y" = 'Y' ] || [ "$y" = 'y' ]; then
    vi ~/.zshrc
    vi ~/.hgrc
    vi ~/.gitconfig
fi
