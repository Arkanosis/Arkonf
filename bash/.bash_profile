if [ -t 0 ]; then

    if [ "$HOSTNAME" = "reddev002" ]; then
    	exec ssh madpc085
    fi

    for localpath in ~/local*; do
    	screen=$localpath/bin/screen
    	if test -x $screen && $screen echo > /dev/null 2>&1; then
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
    	exec $screen $zsh
    fi

fi
