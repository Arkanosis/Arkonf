# "-*- sh -*-"

function whichvcs()
{
	local base_dir

	if [[ -d .svn ]]; then
		echo svn
	elif [[ -d CVS ]]; then
		echo cvs
	else
		base_dir=.
		while [[ ! -d $base_dir/.hg && ! -d $base_dir/.git && `readlink -f "$base_dir"` != / ]]; do
			base_dir=$base_dir/..
		done
		if [[ -d $base_dir/.hg/ ]]; then
		    echo hg
		elif [[ -d $base_dir/.git/ ]]; then
		    echo git
		fi
	fi
}

function vcsroot()
{
    local cmd base_dir

    cmd=$1
    shift

    base_dir=.
    while [[ -d $base_dir/../.svn || -d $base_dir/../CVS ]]; do
	base_dir=$base_dir/..
    done
    $cmd $@ $base_dir
}


function co()
{
    hg clone $@ ||
    svn co $@  ||
    git clone $@  ||
    cvs -d $1 co $2 ||
    (
	echo This is not a know repository >&2
	return 1
    )
}

function colorizeAdd()
{
    while read line; do
	echo `echo $line | sed -e 's/^A[ 	].\+/\\\\e[1;32m&\\\\e[0m/'`
    done
}

function add()
{
    vcs=`whichvcs`
    case $vcs in
	svn)
	    svn add $@ | colorizeAdd
	;;
	cvs)
	    for path; do
		find $path -exec cvs add {} | colorizeAdd \;
	    done
	;;
	hg|git)
	    $vcs add $@
	;;
    esac
}

function ci()
{
    local vcs

    # TODO FIXME when vcsroot will be fixed, make so that :
    # - ci commit the current directory or the given arguments, if there are some (to be fixed for hg, git)
    # - rci commit the whole project (to be fixed for hg, git)
    # same for df / rdf / dfl / rdfl / st / rst...
    vcs=`whichvcs`
    case $vcs in
	svn|cvs)
	    $vcs ci $@
	;;
	hg)
	    hg ci -v $@
	;;
	git)
	    if ((#)); then
		git commit $@
	    else
		git commit -a
	    fi
	;;
    esac
}
function rci()
{
    vcsroot ci $@
}

function push()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
	hg|git)
	    $vcs push $@
	;;
    esac
}

function colorizeStatus()
{
    while read line; do
	echo `echo $line | sed -e 's/^A[ 	].\+/\\\\e[1;32m&\\\\e[0m/' -e 's/^D[ 	].\+/\\\\e[1;31m&\\\\e[0m/' -e 's/^M[ 	].\+/\\\\e[1;34m&\\\\e[0m/' -e 's/^?[ 	].\+/\\\\e[1;35m&\\\\e[0m/' -e 's/35\(m?[ 	].\+\.\\(log\|bak\|local\)\)/90\1/'`
    done
}

function st()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
	svn|cvs)
	    $vcs st $@ | colorizeStatus
	;;
	hg)
	    hg st $@ .
	;;
	git)
	    git st $@
	;;
    esac
}
function rst()
{
    vcsroot st $@
}

function up()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
	svn|cvs)
	    $vcs up $@
	;;
	hg)
	    hg fetch $@
	;;
	git)
	    git pull $@
	;;
    esac
}
function rup()
{
    vcsroot up $@
}

function df()
{
    local vcs base_dir

    vcs=`whichvcs`
    case $vcs in
	svn)
	    svn diff --diff-cmd=colordiff $@
	;;
	cvs)
	    cvs diff $@
	;;
	hg)
	    base_dir=.
	    while [[ ! -d $base_dir/.hg ]]; do
		base_dir=$base_dir/..
	    done
	    for file in `hg st | sed -n '/^M/ s/^M //p'`; do
		echo
		print '\e[1;33m***' $file '***\e[0m'
		hg df $@ $base_dir/$file
	    done
	;;
	git)
	    git df --color $@
	;;
    esac
}
function rdf()
{
    vcsroot df $@
}
function dfl()
{
    df $@ | less
}
function rdfl()
{
    vcsroot dfl $@
}
function dc()
{
    df -r committed $@
}
function rdc()
{
    vcsroot dc $@
}
function dcl()
{
    dfl -r committed $@
}
function rdcl()
{
    vcsroot dcl $@
}

function lcd()
{
    colordiff $@ | less
}

function dlf()
{
    local cmd added removed difference

    cmd=$1
    shift

    added=`$cmd diff $@ | sed -n '/^+/p' | wc -l`
    removed=`$cmd diff $@ | sed -n '/^-/p' | wc -l`
    difference=$((added-removed))
    if ((difference)) then
	echo "+$added\t-$removed\t(\e[32m+$difference\e[0m)"
    else
	echo "+$added\t-$removed\t(\e[31m$difference\e[0m)"
    fi
}

function dla()
{
    local cmd

    cmd=$1
    shift

    for file in `$cmd st | sed -n '/^M/ s/^M //p'`; do
	printf "$file\t"
	dlf $cmd $@ $file
    done
    echo ----------
    printf 'Total\t'
    dlf $cmd $@
}

function dl()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
	*)
	    dla $vcs $@
	;;
    esac
}

function dll()
{
    dl $@ | less
}

function rv()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
       svn|cvs|hg)
	    $vcs revert $@
	;;
	git)
	    git stash $@
	;;
    esac
}

function lg()
{
    local vcs

    vcs=`whichvcs`
    case $vcs in
	*)
	    $vcs log $@
	;;
    esac
}
function rlg()
{
    vcsroot lg $@
}
function lgv()
{
    lg -v $@ | less
}
function rlgv()
{
    vcsroot lgv $@
}
function gl()
{
    hg glog $@ | less
}
function lc()
{
    lg -r committed $@
}
function lcv
{
    lgv -r committed $@
}

function purge()
{
    local files

    files=()

    for file in `nocolor st | sed -n 's/^? \+\(.\+\)$/\1/p'`; do
	files+=($file)
    done

    echo 'Will purge the following files:'
    for file in $files; do
	echo "  $file"
    done
    echo 'Proceed?'
    read y
    if [[ $y != (y|Y) ]]; then
	echo 'Operation aborted' >&2
	return 1
    fi
    rm -r $files
}

function fetch()
{
    up $@
}
function hin()
{
    hg in $@
}
function out()
{
    hg out $@
}
function cu()
{
    svn cleanup $@
}
function rcu()
{
    vcsroot svn cleanup $@
}