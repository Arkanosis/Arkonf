.PHONY: all install \
	awesome \
	bash \
	dotfiles \
	emacs \
	gdb \
	git \
	gtk \
	mercurial \
	gnupg \
	lxc \
	mbsync \
	python \
	pyjab \
	pywikibot \
	screen \
	slrn \
	ssh \
	tmux \
	vim \
	weechat \
	xorg \
	zsh \
	rust

ROOT=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all:
	@echo 'Run "make install" to install Arkonf'

install: \
	awesome \
	bash \
	dotfiles \
	emacs \
	gdb \
	git \
	gtk \
	mercurial \
	gnupg \
	lxc \
	mbsync \
	python \
	pyjab \
	pywikibot \
	screen \
	slrn \
	ssh \
	tmux \
	vim \
	weechat \
	xorg \
	zsh

awesome: ~/.config/awesome
~/.config/awesome:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)$(notdir $@)" "$@"

bash: ~/.bashrc ~/.bash_profile
~/.bashrc:
	ln -s "$(ROOT)bash/$(notdir $@)" "$@"
~/.bash_profile:
	ln -s "$(ROOT)bash/$(notdir $@)" "$@"

dotfiles: ~/.forward ~/.pgpkey ~/.plan ~/.project ~/.signature
~/.forward:
	ln -s "$(ROOT)dotfiles/$(notdir $@)" "$@"
~/.pgpkey:
	ln -s "$(ROOT)dotfiles/$(notdir $@)" "$@"
~/.plan:
	ln -s "$(ROOT)dotfiles/$(notdir $@)" "$@"
~/.project:
	ln -s "$(ROOT)dotfiles/$(notdir $@)" "$@"
~/.signature:
	ln -s "$(ROOT)dotfiles/$(notdir $@)" "$@"

emacs: ~/.emacs ~/.emacs.d
~/.emacs:
	ln -s "$(ROOT)emacs/$(notdir $@)" "$@"
~/.emacs.d:
	ln -s "$(ROOT)emacs/$(notdir $@)" "$@"

gdb: ~/.gdbinit
~/.gdbinit:
	ln -s "$(ROOT)gdb/$(notdir $@)" "$@"

git: ~/.gitconfig ~/.tigrc
~/.gitconfig:
	ln -s "$(ROOT)git/$(notdir $@)" "$@"
~/.tigrc:
	ln -s "$(ROOT)git/$(notdir $@)" "$@"
mercurial: ~/.hgrc
~/.hgrc:
	ln -s "$(ROOT)mercurial/$(notdir $@)" "$@"

gnupg: ~/.gnupg/gpg.conf ~/.gnupg/gpg-agent.conf
~/.gnupg/gpg.conf:
	ln -s "$(ROOT)gnupg/$(notdir $@)" "$@"
~/.gnupg/gpg-agent.conf:
	ln -s "$(ROOT)gnupg/$(notdir $@)" "$@"

gtk: ~/.gtkrc-2.0 ~/.config/gtk-3.0/bookmarks
~/.gtkrc-2.0:
	ln -s "$(ROOT)gtk/$(notdir $@)" "$@"
~/.config/gtk-3.0/bookmarks:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)gtk/$(notdir $@)" "$@"

lxc: ~/.config/lxc/default.conf
~/.config/lxc/default.conf:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)lxc/$(notdir $@)" "$@"

mbsync: ~/.mbsyncrc
~/.mbsyncrc:
	ln -s "$(ROOT)mbsync/$(notdir $@)" "$@"

python: ~/.pythonrc.py ~/.config/pudb/pudb.cfg ~/.ptpython/config.py
~/.pythonrc.py:
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.config/pudb/pudb.cfg:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.ptpython/config.py:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"

pyjab: ~/.pyjabrc
~/.pyjabrc:
	ln -s "$(ROOT)pyjab/$(notdir $@)" "$@"

pywikibot: ~/.pywikibot
~/.pywikibot:
	ln -s "$(ROOT)pywikibot/$(notdir $@)" "$@"

screen: ~/.screenrc
~/.screenrc:
	ln -s "$(ROOT)mbsync/$(notdir $@)" "$@"

slrn: ~/.slrnrc
~/.slrnrc:
	ln -s "$(ROOT)mbsync/$(notdir $@)" "$@"

ssh: ~/.ssh/config
~/.ssh/config:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)ssh/.ssh/$(notdir $@)" "$@"

tmux: ~/.tmux.conf ~/.tmux
~/.tmux.conf:
	ln -s "$(ROOT)tmux/$(notdir $@)" "$@"
~/.tmux:
	ln -s "$(ROOT)tmux/$(notdir $@)" "$@"

vim: ~/.vimrc ~/.vim
~/.vimrc:
	ln -s "$(ROOT)vim/$(notdir $@)" "$@"
~/.vim:
	ln -s "$(ROOT)vim/$(notdir $@)" "$@"

xorg: ~/.xinitrc ~/.Xdefaults ~/.Xmodmap ~/.Xresources
~/.xinitrc:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"
~/.Xdefaults:
	ln -s "$(ROOT)xorg/.Xresources" "$@"
~/.Xmodmap:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"
~/.Xresources:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"

weechat: ~/.weechat
~/.weechat:
	ln -s "$(ROOT)weechat/$(notdir $@)" "$@"

zsh: ~/.zshrc ~/.zsh
~/.zshrc:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"
~/.zsh:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"

rust:
	curl "https://sh.rustup.rs" -sSf | sh
	rustup component add rust-src
	cargo install racer
