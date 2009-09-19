#! /bin/sh

installPath=`pwd`/`dirname $0`
while echo $installPath | grep '\.\.' > /dev/null; do
    installPath=`echo $installPath | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done

install()
{
    test -f "$2" && echo "\033[31m$2 already exist, skipped\033[0m" || ( ln -s "$installPath/$1" "$2" && echo "\033[32m$2 succefully installed\033[0m" )
}

echo '\033[33mArkinstall v0.1'
echo '(C) 2009 - Arkanosis'
echo 'arkanosis@gmail.com'
echo
echo 'Check for latest version at http://github.com/Arkanosis/Arkonf\033[0m'

install zsh/.zshrc ~/.zshrc
install mercurial/.hgrc ~/.hgrc
install git/.gitconfig ~/.gitconfig
install fluxbox ~/.fluxbox
install emacs/.emacs ~/.emacs
install emacs/.emacs.d ~/.emacs.d
install vim/.vimrc ~/.vimrc
install xorg/.Xmodmap ~/.Xmodmap
