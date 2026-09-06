#! /bin/sh

# Cinny build script
# (C) 2026 Jérémie Roquet <jroquet@arkanosis.net>

set -e

VERSION='v0.1.0'

APPDIR="$(dirname "$(readlink -f "$0")")"

usage() {
    echo 'Usage: build_cinny.sh <version>'
    echo '       build_cinny.sh -h | --help'
    echo '       build_cinny.sh --version'
}

if [ $# -eq 0 ] || [ "x$1" = 'x-h' ] || [ "x$1" = 'x--help' ]; then
    usage
    exit 0
elif [ "x$1" = 'x--version' ]; then
    echo "build_cinny.sh $VERSION"
    exit 0
elif [ $# -ne 1 ]; then
    usage >&2
    exit 1
fi

VERSION="$1"

sbox() {
    bwrap \
        --unshare-all \
        --share-net \
        --new-session \
        --ro-bind '/usr' '/usr' \
        --setenv 'PATH' '/usr/bin' \
        --ro-bind '/lib' '/lib' \
        --ro-bind '/lib64' '/lib64' \
        --ro-bind '/etc/resolv.conf' '/etc/resolv.conf' \
        --ro-bind '/etc/hosts' '/etc/hosts' \
        --dev-bind '/dev/null' '/dev/null' \
        --proc '/proc' \
        --tmpfs '/tmp' \
        --tmpfs "$HOME" \
        --bind "$(pwd)" '/app' \
        --chdir '/app' \
        "$@"
}

# Upgrade code
git fetch
git checkout "v$VERSION"
sed -i "s@base: '/'@base: '/cinny'@" 'build.config.ts'

# Install dependencies and auto-apply fixes that do not need attention (in a sandbox)
if ! sbox npm install; then
    sbox npm audit fix
fi

# Validate code an auto-applied fixes
git diff
read -p "Validate code state [y/N]" validated
if [ "x$validated" != 'xy' ] && [ "x$validated" != 'xY' ]; then
    echo 'Not validated, aborting'
    exit 2
fi

# Install dependencies that have been fixed (if any, in a sandbox)
# If it doesn't work, it means some fixes require human attention
if ! sbox npm install; then
    read -p "Dependencies issues after auto-applied fixes. Validate code state [y/N]" validated
    if [ "x$validated" != 'xy' ] && [ "x$validated" != 'xY' ]; then
	echo 'Not validated, aborting'
	exit 2
    fi
fi

# Build (in a sandbox)
sbox npm run build

# Get reference build
REFERENCE="$(mktemp -d)"
(
    cd "$REFERENCE"
    wget "https://github.com/cinnyapp/cinny/releases/download/v$VERSION/cinny-v$VERSION.tar.gz.asc"
    wget "https://github.com/cinnyapp/cinny/releases/download/v$VERSION/cinny-v$VERSION.tar.gz"
    gpg --verify "cinny-v$VERSION.tar.gz.asc"
    tar xvzf "cinny-v$VERSION.tar.gz"
)

# Compare self-build dist and reference build dist
kdiff3 'dist/' "$REFERENCE/dist"

read -p "Validate self-build dist [y/N]" validated
if [ "x$validated" != 'xy' ] && [ "x$validated" != 'xY' ]; then
    echo 'Not validated, aborting'
    exit 2
fi

# Upload to Bismuth
rsync -aAXzz --info=progress2 'dist/' "Bismuth.nebula:/tmp/cinny-v$VERSION-selfbuilt-dist/"
