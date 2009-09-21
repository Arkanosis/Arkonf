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

    ZARKONF_DIR="$HOME/Arkonf/zsh"
    ZARKONF_CACHE="$HOME/.zcache"

    pushd "$ZARKONF_DIR/.zsh" >&-

    source ./zshrc

    case "$HOST" in
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
else
    printf "\033[91;1m>>>> You are on gate-ssh, forwarding you to freebsd\033[0m\n"
    ssh freebsd
    printf "\033[91;1m>>>> Back on gate-ssh... EXIT NOW \!\!\!\033[0m\n"
    exit
fi

# Garder un ligne vide a la fin, sinon la derniere commande n'est pas executee
