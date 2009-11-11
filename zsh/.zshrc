# "-*- sh -*-"

#  Zsh Conf - Basée sur zArkonf v0.7
#  (C) 2007-2009 - Arkanosis
#  arkanosis@gmail.com

if [ "$HOST" != 'gate-ssh' ]; then
    LOGIN='roquet_j'
    PSEUDO="Arkanosis"
    EMAIL='arkanosis@gmail.com'
    SOCKS_PASSWORD=''
    PROXY_HOST=''
    PROXY_PORT=''
    NNTPSERVER='news.epita.fr'
    #PROMPT_COLOR="3`echo $(($RANDOM*6/32767+1))`"
    PROMPT_COLOR='cyan'

    ARKONF_DIR="$HOME/Arkonf"
    ZARKONF_DIR="$ARKONF_DIR/zsh"
    ZARKONF_CACHE="$HOME/.zcache"

    MONITORED_PAGES=(
	'W|http://fr.wikipedia.org/wiki/Discussion_utilisateur:Arkanosis'
    )

    pushd "$ZARKONF_DIR/.zsh" >&-

    if [[ $HOST = mad* ]]; then
	source ./exalead
    fi

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
	mad*)
	    source ./exalead
	;;
	*)
	    if which ns_who >&-; then
		source ./epita
	    fi
	;;
    esac

    popd >&-

    #enable_proxy
else
    printf "\e[91;1m>>>> You are on gate-ssh, forwarding you to freebsd\e[0m\n"
    ssh freebsd
    printf "\e[91;1m>>>> Back on gate-ssh... EXIT NOW \!\!\!\e[0m\n"
    exit
fi

# Garder un ligne vide a la fin, sinon la derniere commande n'est pas executee
