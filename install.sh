#! /bin/sh

installPath=`pwd`/`dirname $0`
while echo $installPath | grep '\.\.' > /dev/null; do
    installPath=`echo $installPath | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done

check()
{
    # TODO check canonicalize
    echo
}

install()
{
    test -e "$2" && printf "\033[31m$2 already exist, skipped\033[0m\n" || ( ln -s "$installPath/$1" "$2" && printf "\033[32m$2 succefully installed\033[0m\n" )
}

printf '\033[33mArkinstall v0.1\n'
printf '(C) 2009-2012 - Arkanosis\n'
printf 'arkanosis@gmail.com\n'
printf 'Check for latest version at http://github.com/Arkanosis/Arkonf\033[0m\n'

echo

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

install pyjab/.pyjabrc ~/.pyjabrc

install slrn/.slrnrc ~/.slrnrc

install screen/.screenrc ~/.screenrc
install tmux/.tmux.conf ~/.tmux.conf

install uncrustify/.uncrustifyrc ~/.uncrustifyrc

install vim/.vimrc ~/.vimrc
install vim/.vim ~/.vim

install awesome ~/.config/awesome
install fluxbox/.fluxbox ~/.fluxbox
install xmonad ~/.xmonad

install xorg/.Xmodmap ~/.Xmodmap
install xorg/.Xresources ~/.Xresources
install xorg/.Xresources ~/.Xdefaults

echo

echo 'Edit the configuration files? [yN]'
read y
if [ "$y" = 'Y' ] || [ "$y" = 'y' ]; then
    vi ~/.zshrc
    vi ~/.hgrc
    vi ~/.gitconfig
fi
