# "-*- sh -*-"

EMAIL='jroquet@arkanosis.net'
SOCKS_PASSWORD=''
PROXY_HOST=''
PROXY_PORT=''
NNTPSERVER='news.epita.fr'
PROMPT_COLOR='cyan'

ZARKONF_DIR="${${(%):-%x}:A:h}"
ARKONF_DIR="$ZARKONF_DIR:h"
ZARKONF_CACHE="$HOME/.zcache"
ZARKONF_TODO="$HOME/.ztodo"

MONITORED_PAGES=(
)

pushd "$ZARKONF_DIR/.zsh" > /dev/null

source ./zshrc

case $HOST in
    Edelweiss)
	source ~/.cargo/env
    ;;
    marvin)
	if [[ $TERM = linux ]]; then
	    setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz
	fi
	source ~/.cargo/env
    ;;
    redsol*|tcsol*)
	source ./exalead
	NO_VCS_INFO=True
	export PATH=/opt/csw/bin:/opt/sfw/bin:/ng/sdk/tools/devenv/bin:/ng/bin:/bin:/usr/bin:$PATH
	export LD_LIBRARY_PATH=/opt/csw/lib:$LD_LIBRARY_PATH
    ;;
    reddev*|tcdev*|*dsy|lenov*|ngci*|ngdev*|nglqa*|nglapo*|lxc*|local_Linux-x86_64)
	source ./exalead
	if lsb_release -i | grep -q "RedHat\|CentOS\|Scientific"; then
	    export PATH=/udir/jroquet/local_RedHat/bin:$PATH
	    export LD_LIBRARY_PATH=~/local_RedHat/lib:$LD_LIBRARY_PATH
	fi
    ;;
esac

popd > /dev/null
