.PHONY: all install

# TODO port the full install.sh to this Makefile

ROOT=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all:
	@echo 'Run "make install" to install Arkonf'

install: \
	dotfiles \
	git \
	mercurial \
	python \
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

git: ~/.gitconfig
~/.gitconfig:
	ln -s "$(ROOT)git/$(notdir $@)" "$@"
mercurial: ~/.hgrc
~/.hgrc:
	ln -s "$(ROOT)mercurial/$(notdir $@)" "$@"

python: ~/.pythonrc.py ~/.config/pudb/pudb.cfg ~/.ptpython/config.py
~/.pythonrc.py:
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.config/pudb/pudb.cfg:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"
~/.ptpython/config.py:
	mkdir -p "$(dir $@)"
	ln -s "$(ROOT)python/$(notdir $@)" "$@"

zsh: ~/.zshrc ~/.zsh
~/.zshrc:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"
~/.zsh:
	ln -s "$(ROOT)zsh/$(notdir $@)" "$@"

rust:
	curl "https://sh.rustup.rs" -sSf | sh
	rustup component add rust-src
	cargo install racer
