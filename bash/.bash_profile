if [ -t 0 ]; then

    if [ "$HOSTNAME" = "reddev002" ]; then
    	exec ssh madpc085
    fi

    for localpath in ~/local*; do
    	screen=$localpath/bin/screen
	# TODO check this screen binary is compatible with the system, without running a screen session
    	if test -x $screen; then
    	    echo screen from $screen
    	    break
    	fi
    	screen=
    done

    for localpath in ~/local*; do
    	zsh=$localpath/bin/zsh
    	if test -x $zsh && $zsh -c 'echo' > /dev/null 2>&1; then
    	    echo zsh from $zsh
    	    break
    	fi
    	zsh=
    done

    if [ -z $screen ] && [ -x "`which screen`" ]; then
    	screen=screen
    fi
    if [ -z $zsh ] && [ -x "`which zsh`" ]; then
    	zsh=zsh
    fi

    if ! [ -z $zsh ]; then
	export FULLSHELL=`which $zsh`
	exec $screen
    fi

fi
