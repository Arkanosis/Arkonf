# "-*- sh -*-"

#  ZSH configuration
#  (C) 2007-2016 - Jérémie Roquet
#  jroquet@arkanosis.net

if [ "$HOST" != 'gate-ssh' ]; then
    EMAIL='jroquet@arkanosis.net'
    SOCKS_PASSWORD=''
    PROXY_HOST=''
    PROXY_PORT=''
    NNTPSERVER='news.epita.fr'
    #PROMPT_COLOR="3`echo $(($RANDOM*6/32767+1))`"
    PROMPT_COLOR='cyan'

    ARKONF_DIR="$HOME/Arkonf"
    ZARKONF_DIR="$ARKONF_DIR/zsh"
    ZARKONF_CACHE="$HOME/.zcache"
    ZARKONF_TODO="$HOME/.ztodo"

    MONITORED_PAGES=(
    )

    pushd "$ZARKONF_DIR/.zsh" > /dev/null

    source ./zshrc

    case $HOST in
	redsol*|tcsol*)
	    source ./exalead
	    NO_VCS_INFO=True
	    export PATH=/opt/csw/bin:/opt/sfw/bin:/ng/sdk/tools/devenv/bin:/ng/bin:/bin:/usr/bin:$PATH
	    export LD_LIBRARY_PATH=/opt/csw/lib:$LD_LIBRARY_PATH
	;;
	reddev*|tcdev*|*dsy|lenov*|ngci*|ngdev*|nglqa*|lxc*|local_Linux-x86_64)
	    source ./exalead
	    if lsb_release -i | grep -q "RedHat\|CentOS\|Scientific"; then
		export PATH=/udir/jroquet/local_RedHat/bin:$PATH
		export LD_LIBRARY_PATH=~/local_RedHat/lib:$LD_LIBRARY_PATH
	    fi
	;;
    esac

    popd > /dev/null

    #enable_proxy
else
    printf "\e[91;1m>>>> You are on gate-ssh, forwarding you to freebsd\e[0m\n"
    ssh freebsd
    printf "\e[91;1m>>>> Back on gate-ssh... EXIT NOW \!\!\!\e[0m\n"
    exit
fi

# Garder une ligne vide a la fin, sinon la derniere commande n'est pas executee
