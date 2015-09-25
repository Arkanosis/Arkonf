# "-*- sh -*-"

#  Zsh Conf - Basée sur zArkonf v0.7
#  (C) 2007-2009 - Arkanosis
#  jroquet@arkanosis.net

if [ "$HOST" != 'gate-ssh' ]; then
    LOGIN='arkanosis'
    PSEUDO="Arkanosis"
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
	lisp|caml|ruby|ada|php|asp|sh|java|apl|pascal|xenadev)
	    source ./acu
	;;
	Cyclamen)
	    source ./cyclamen
	;;
	Edelweiss)
	    source ./edelweiss
	;;
	reddev0(0|1)4|(ng|tc)dev00(2|3))
	    source ./exalead
	    export PATH=$PATH:s/Linux-x86_64/RedHat/
	;;
	redsol*|tcsol*)
	    source ./exalead
	    NO_VCS_INFO=True
	    export PATH=/opt/csw/bin:/opt/sfw/bin:/ng/sdk/tools/devenv/bin:/ng/bin:/bin:/usr/bin:$PATH
	;;
	mad*|reddev*|tcdev*|*dsy|lenov*|ngci*)
	    source ./exalead
	;;
	*)
	    if which ns_who > /dev/null; then
		source ./epita
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

# Garder un ligne vide a la fin, sinon la derniere commande n'est pas executee
