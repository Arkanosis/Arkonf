# This works on most machines, given they have up-to-date zsh and tmux binaries.
# Not having zsh or tmux is not an issue, but having an outdated version can be.
# For RedHat, prefer building zsh on RHEL 5 with --disable-gdbm to avoid dependencies
# that wouldn't be available everywhere, and don't forget to build libevent for tmux.
# Building zsh and tmux on AIX / Solaris can be quite a challenge, but it is possible!

if [[ -t 0 ]]; then

    if [[ "$HOSTNAME" = "reddev002" ]]; then
        exec ssh lenov012cem
    fi

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

    export FULLSHELL=$(which bash)
    if [[ -x $(which zsh) ]]; then
	export FULLSHELL=$(which zsh)
    fi

    if [[ -z $TMUX && -x $(which tmux) ]]; then
	exec tmux
    fi

    if [[ -x $(which zsh) ]]; then
	exec zsh
    fi

fi
