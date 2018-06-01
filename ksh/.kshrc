if [ -t 0 ]; then

    # Don't do anything too fancy with the root account, but otherwise
    # spawn a bash if available, as bash knows how to spawn a zsh :)

    if [ $EUID -ne 0 ]; then

	if [[ -x $(which bash) ]]; then
	    export SHELL=$(which bash)
	    exec $SHELL
	fi

    fi

fi
