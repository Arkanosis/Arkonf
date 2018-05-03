if [[ -t 0 ]]; then

    if [[ $EUID -eq 0 ]]; then

	# Don't do anything too fancy with the root account

	if [[ "$HOSTNAME" = "marvin" ]]; then
	    echo 500 > /sys/class/backlight/intel_backlight/brightness
	    setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

	    export EDITOR='emacs -nw'
	    export GPG_TTY=$(tty)
	    export LANGUAGE=fr_FR.utf-8
	    export LANG=fr_FR.utf-8
	    export LC_ALL=fr_FR.utf-8
	fi

    else

	# Not root, so got to the right machine if on a gateway and
	# spawn a fancy shell in a fancy virtual terminal, if available for the platform

	if [[ "$HOSTNAME" = "reddev002" ]]; then
	    exec ssh dell2323dsy
	fi

	# This works on most machines, given they have up-to-date zsh and tmux binaries.
	# Not having zsh or tmux is not an issue, but having an outdated version can be.
	# For RedHat, prefer building zsh on RHEL 5 with --disable-gdbm to avoid dependencies
	# that wouldn't be available everywhere, and don't forget to build libevent for tmux.
	# Building zsh and tmux on AIX / Solaris can be quite a challenge, but it is possible!

	os=$(uname -s)
	arch=$(uname -p)

	export PATH=~/local_$os-$arch/bin:$PATH
	export LD_LIBRARY_PATH=~/local_$os-$arch/lib:$LD_LIBRARY_PATH

	if [[ -x $(which lsb_release) ]] && lsb_release -i | grep -q "RedHat\|CentOS\|Scientific"; then
	    export PATH=~/local_RedHat/bin:$PATH
	    export LD_LIBRARY_PATH=~/local_RedHat/lib:$LD_LIBRARY_PATH
	fi

	export TERM=xterm
	if [[ -f /lib/terminfo/x/xterm-256color ]]; then
	    export TERM=xterm-256color
	fi

	export SHELL=$(which bash)
	if [[ -x $(which zsh) ]]; then
	    export SHELL=$(which zsh)
	fi

	if [[ -z $TMUX && -x $(which tmux) ]]; then
	    if [[ -f /lib/terminfo/s/screen-256color ]]; then
		export TERM=screen-256color
	    fi
	    exec tmux
	fi

	exec $SHELL

    fi

fi
