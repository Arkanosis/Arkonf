.PHONY: all install \
	dotfiles \
	emacs \
	gdb \
	git \
	mercurial \
	lxc \
	python \
	ssh \
	tmux \
	zsh \
	rust

# TODO port the full install.sh to this Makefile

ROOT=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all:
	@echo 'Run "make install" to install Arkonf'

install: \
	dotfiles \
	emacs \
	gdb \
	git \
	mercurial \
	lxc \
	python \
	ssh \
	tmux \
	zsh

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

lxc: ~/.config/lxc/default.conf
~/.config/lxc/default.conf:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)lxc/$(notdir $@)" "$@"

python: ~/.pythonrc.py ~/.config/pudb/pudb.cfg ~/.ptpython/config.py
~/.pythonrc.py:
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.config/pudb/pudb.cfg:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.ptpython/config.py:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"

ssh: ~/.ssh/config
~/.ssh/config:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)ssh/.ssh/$(notdir $@)" "$@"

tmux: ~/.tmux.conf
~/.tmux.conf:
	ln -s "$(ROOT)tmux/$(notdir $@)" "$@"

zsh: ~/.zshrc ~/.zsh
~/.zshrc:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"
~/.zsh:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"

rust:
	curl "https://sh.rustup.rs" -sSf | sh
	rustup component add rust-src
	cargo install racer
