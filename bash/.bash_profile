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

    elif [[ "$USER" = "nonfreegaming" ]]; then

        # Since we're there for gaming, start a graphical environment right now if there isn't one already

        if systemctl -q is-active graphical.target && [[ ! $DISPLAY ]]; then
            exec startx
        fi

    elif [[ "$HOSTNAME" = "reddev002" ]]; then

        # Don't do anything too fancy on the gateway, go to the right machine instead

        exec ssh dell2323dsy

    elif [[ "$TERM" = "dumb" ]]; then

        # Don't do anything too fancy on a dumb terminal (eg. Emacs TRAMP)

        export PS1='> '

    else

        # Spawn a fancy shell in a fancy virtual terminal, if available for the platform

        # Set a basic prompt to feel at home even if ending up having only bash available
        export PS1='\033[1;33m\h\033[0;33m \w\n\!\033[1;33m $\033[0m '

        # This works on most machines, given they have up-to-date zsh and tmux binaries.
        # Not having zsh or tmux is not an issue, but having an outdated version can be.
        # For RedHat, prefer building zsh on RHEL 5 with --disable-gdbm to avoid dependencies
        # that wouldn't be available everywhere, and don't forget to build libevent for tmux.
        # Building zsh and tmux on AIX / Solaris can be quite a challenge, but it is possible!

        os=$(uname -s)
        arch=$(uname -p)

        export PATH=~/.local_$os-$arch/bin:$PATH
        export LD_LIBRARY_PATH=~/.local_$os-$arch/lib:$LD_LIBRARY_PATH

        if [[ -x $(which lsb_release 2> /dev/null) ]] && lsb_release -i | grep -q "RedHat\|CentOS\|Scientific"; then
            export PATH=~/.local_RedHat/bin:$PATH
            export LD_LIBRARY_PATH=~/.local_RedHat/lib:$LD_LIBRARY_PATH
        fi

        export TERM=xterm
        if [[ -f /lib/terminfo/x/xterm-256color ]]; then
            export TERM=xterm-256color
        fi

        export SHELL=$(which bash 2> /dev/null)
        if [[ -x $(which zsh 2> /dev/null) ]]; then
            export SHELL=$(which zsh 2> /dev/null)
        fi

        if [[ -z $TMUX && -z $STY ]]; then
            if [[ -x $(which tmux 2> /dev/null) ]]; then
                if [[ -f /lib/terminfo/s/screen-256color ]]; then
                    export TERM=screen-256color
                fi
                if ! tmux has-session -t '-' 2> /dev/null; then
                    exec tmux new-session -s '-'
                elif tmux list-sessions -F '#S #{session_attached}' | grep -qxF -- '- 0'; then
                    exec tmux attach-session -t '-'
                else
                    exec tmux
                fi
            elif [[ -x $(which screen 2> /dev/null) ]]; then
                if [[ -f /lib/terminfo/s/screen-256color ]]; then
                    export TERM=screen-256color
                fi
                exec screen
            fi
        fi

        if [[ $SHELL != $(which bash 2> /dev/null) ]]; then
            exec $SHELL
        fi

    fi

fi
