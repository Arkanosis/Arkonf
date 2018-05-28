CONFIGS= \
	autoconf \
	awesome \
	bash \
	dotfiles \
	emacs \
	gdb \
	git \
	gnupg \
	gtk \
	kde \
	lxc \
	mbsync \
	mercurial \
	python \
	pyjab \
	pywikibot \
	screen \
	slrn \
	ssh \
	totp \
	tmux \
	vim \
	weechat \
	xorg \
	zsh

.PHONY: all \
	install \
	rust \
	$(CONFIGS)

ROOT=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

help:
	@echo 'Run "make install" to install Arkonf, or chose a target among: "'$(CONFIGS)'"'

install: $(CONFIGS)

autoconf: ~/.config.site
~/.config.site:
	echo "prefix=$${HOME}/local_$$(uname -sm | tr ' ' '-')" > "$@"

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

kde: ~/.kde/share/config/khotkeysrc ~/.kde/share/config/kwinrc ~/.local/share/user-places.xbel ~/.kde/share/config/yakuakerc
~/.kde/share/config/khotkeysrc:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)kde/$(notdir $@)" "$@"
~/.kde/share/config/kwinrc:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)kde/$(notdir $@)" "$@"
~/.local/share/user-places.xbel:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)kde/$(notdir $@)" "$@"
~/.kde/share/config/yakuakerc:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)kde/$(notdir $@)" "$@"

lxc: ~/.config/lxc/default.conf
~/.config/lxc/default.conf:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)lxc/$(notdir $@)" "$@"

mbsync: ~/.mbsyncrc
~/.mbsyncrc:
	ln -s "$(ROOT)mbsync/$(notdir $@)" "$@"

mercurial: ~/.hgrc
~/.hgrc:
	ln -s "$(ROOT)mercurial/$(notdir $@)" "$@"

python: ~/.pythonrc.py ~/.config/pudb/pudb.cfg ~/.ptpython/config.py ~/.pydistutils.cfg
~/.pythonrc.py:
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.config/pudb/pudb.cfg:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.ptpython/config.py:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.pydistutils.cfg:
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
	sed -i "s@^prefix=.*@prefix=$${HOME}/local@" "$@"

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

totp: ~/.google_authenticator
~/.google_authenticator:
	google-authenticator

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

weechat: ~/.weechat
~/.weechat:
	ln -s "$(ROOT)weechat/$(notdir $@)" "$@"

xorg: ~/.xinitrc ~/.Xdefaults ~/.Xmodmap ~/.Xresources
~/.xinitrc:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"
~/.Xdefaults:
	ln -s "$(ROOT)xorg/.Xresources" "$@"
~/.Xmodmap:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"
~/.Xresources:
	ln -s "$(ROOT)xorg/$(notdir $@)" "$@"

zsh: ~/.zshrc ~/.zsh
~/.zshrc:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"
~/.zsh:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"

rust:
	curl "https://sh.rustup.rs" -sSf | sh
	rustup component add rust-src
	cargo install racer
