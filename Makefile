
CONFIGS= \
	autoconf \
	awesome \
	bash \
	dhex \
	dotfiles \
	emacs \
	gdb \
	git \
	gnupg \
	gtk \
	kde \
	ksh \
	lxc \
	mbsync \
	mercurial \
	python \
	pyjab \
	pywikibot \
	screen \
	slrn \
	ssh \
	sxhkd \
	totp \
	tmux \
	vim \
	weechat \
	xdg \
	xlunch \
	xorg \
	zsh

SERVICES= \
	emacs \
	org

.PHONY: all \
	firefox \
	install \
	rust \
	$(CONFIGS)

ROOT=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

help:
	@echo 'Run "make install" to install Arkonf, or chose a target among: "'$(CONFIGS)'"'

install: $(CONFIGS)

autoconf: ~/.config.site
~/.config.site:
	echo "prefix=$${HOME}/.local_$$(uname -sm | tr ' ' '-')" > "$@"

awesome: ~/.config/awesome
~/.config/awesome:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)$(notdir $@)" "$@"

bash: ~/.bashrc ~/.bash_profile
~/.bashrc:
	ln -s "$(ROOT)bash/$(notdir $@)" "$@"
~/.bash_profile:
	ln -s "$(ROOT)bash/$(notdir $@)" "$@"

dhex: ~/.dhexrc
~/.dhexrc:
	ln -s "$(ROOT)dhex/$(notdir $@)" "$@"

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
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)gnupg/$(notdir $@)" "$@"
~/.gnupg/gpg-agent.conf:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)gnupg/$(notdir $@)" "$@"

gtk: ~/.gtkrc-2.0 ~/.config/gtk-3.0/bookmarks
~/.gtkrc-2.0:
	ln -s "$(ROOT)gtk/$(notdir $@)" "$@"
~/.config/gtk-3.0/bookmarks:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)gtk/gtk-3.0/$(notdir $@)" "$@"

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

ksh: ~/.kshrc
~/.kshrc:
	ln -s "$(ROOT)ksh/$(notdir $@)" "$@"

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
	sed -i "s@^prefix=.*@prefix=$${HOME}/.local@" "$@"

pyjab: ~/.pyjabrc
~/.pyjabrc:
	ln -s "$(ROOT)pyjab/$(notdir $@)" "$@"

pywikibot: ~/.pywikibot
~/.pywikibot:
	ln -s "$(ROOT)pywikibot/$(notdir $@)" "$@"

screen: ~/.screenrc
~/.screenrc:
	ln -s "$(ROOT)screen/$(notdir $@)" "$@"

slrn: ~/.slrnrc
~/.slrnrc:
	ln -s "$(ROOT)slrn/$(notdir $@)" "$@"

ssh: ~/.ssh/config
~/.ssh/config:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)ssh/.ssh/$(notdir $@)" "$@"

sxhkd: ~/.config/sxhkd/sxhkdrc
~/.config/sxhkd/sxhkdrc:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)sxhkd/$(notdir $@)" "$@"

systemd: $(patsubst %,~/.config/systemd/user/%.service,$(SERVICES))
/var/lib/systemd/linger/${USER}:
	@echo 'Ask your administrator to run "sudo loginctl enable-linger '${USER}'" to enable session-independant systemd user services'
%.service: /var/lib/systemd/linger/${USER}
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)systemd/$(notdir $@)" "$@"
	systemctl --user enable --now "$(notdir $@)"

totp: ~/.google_authenticator
~/.google_authenticator:
	echo 'y\ny\ny\nn\ny' | google-authenticator

tmux: ~/.tmux.conf ~/.tmux
~/.tmux.conf:
	ln -s "$(ROOT)tmux/$(notdir $@)" "$@"
~/.tmux:
	ln -s "$(ROOT)tmux/$(notdir $@)" "$@"

vim: ~/.vimrc
~/.vimrc:
	ln -s "$(ROOT)vim/$(notdir $@)" "$@"

weechat: ~/.weechat
~/.weechat:
	ln -s "$(ROOT)weechat/$(notdir $@)" "$@"

xdg: ~/.config/mimeapps.list
~/.config/mimeapps.list:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)xdg/$(notdir $@)" "$@"

xlunch: ~/.config/xlunch/xlunch.conf ~/.local/share/xlunch/background.jpg ~/.local/share/xlunch/icons
~/.config/xlunch/xlunch.conf:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)xlunch/$(notdir $@)" "$@"
~/.local/share/xlunch/background.jpg:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)xlunch/$(notdir $@)" "$@"
~/.local/share/xlunch/icons:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)xlunch/$(notdir $@)" "$@"

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

FIREFOX_FILES= \
	chrome/userChrome.css \
	chrome/userContent.css \
	containers.json \
	storage.js \
	user.js

firefox:
	for profile in ~/.mozilla/firefox/*.*/; do \
		for file in $(FIREFOX_FILES); do \
			if ! [ -e "$${profile}$${file}" ]; then \
				mkdir -p $$(dirname "$${profile}$${file}"); \
				ln -s "$(ROOT)firefox/$${file}" "$${profile}$${file}"; \
			fi; \
		done; \
	done

rust:
	curl "https://sh.rustup.rs" -sSf | sh
	rustup component add rust-src
	cargo install racer
