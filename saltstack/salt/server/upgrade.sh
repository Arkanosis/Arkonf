#! /bin/sh

# Server upgrade script (for stuff not in Debian yet)
# (C) 2026 Jérémie Roquet <jroquet@arkanosis.net>
# Released under the ISC license

set -e

VERSION='v0.1.0'

APPDIR="$(dirname "$(readlink -f "$0")")"

usage() {
    echo 'Usage: upgrade.sh cinny <version>'
    echo '       upgrade.sh conduit <version>'
    echo '       upgrade.sh gotosocial <version>'
    echo '       upgrade.sh nebula <version>'
    echo '       upgrade.sh ntfy <version>'
    echo '       upgrade.sh -h | --help'
    echo '       upgrade.sh --version'
}

if [ $# -eq 0 ] || [ "x$1" = 'x-h' ] || [ "x$1" = 'x--help' ]; then
    usage
    exit 0
elif [ "x$1" = 'x--version' ]; then
    echo "upgrade.sh $VERSION"
    exit 0
elif [ $# -ne 2 ]; then
    usage >&2
    exit 1
fi

PACKAGE="$1"
VERSION="$2"
START="$(date)"
BACKUPS="backups/$(date --iso-8601)"

verify() {
    file="$1"
    sha256sum "$file"
    read -p 'Verify checksum [y/N]' verified
    if [ "x$verified" != 'xy' ] && [ "x$verified" != 'xY' ]; then
	echo 'Checksum not verified, aborting'
	exit 2
    fi
}

case "$PACKAGE" in
    'cinny')
	directory="/tmp/cinny-v${VERSION}-selfbuilt-dist"
	read -p "Self-compile and rsync to '$directory' [y/N]" compiled
	if [ "x$compiled" != 'xy' ] && [ "x$compiled" != 'xY' ]; then
	    echo 'Not self-compiled, aborting'
	    exit 2
	fi
	backup="$BACKUPS/$PACKAGE"
	mkdir -p "$backup"
	tree \
	   "$directory" \
	   "$backup"
	exit 42
	sudo mv -i '/var/sftp/sftp-arkanosis-net/arkanosis.net/cinny' "$backup/" && \
	    sudo -u sftp-arkanosis-net cp -a "$directory" '/var/sftp/sftp-arkanosis-net/arkanosis.net/cinny' && \
	    sudo cp "$backup/cinny/config.json" '/var/sftp/sftp-arkanosis-net/arkanosis.net/cinny/config.json'
    ;;
    'conduit')
	file="conduit_x86_64-unknown-linux-musl.deb"
	wget 'https://gitlab.com/api/v4/projects/famedly%2Fconduit/jobs/artifacts/master/raw/x86_64-unknown-linux-musl.deb?job=artifacts' -O "$file"
	verify "$file"
	ar xv "$file"
	rm "$file"
	tar tvzf 'data.tar.gz'
	rm 'data.tar.gz'
	directory="$(basename -s .tar.gz "$file")"
	backup="$BACKUPS/$PACKAGE"
	mkdir -p "$backup"
	tree \
	   "$directory" \
	   "$backup"
	exit 42
	sudo cp -i '/usr/bin/conduit' "$backup/" && \
	    sudo systemctl stop conduit && \
	    sudo cp "$directory/usr/sbin/matrix-conduit" '/usr/bin/conduit' && \
	    sudo chmod 755 '/usr/bin/conduit' && \
	    sudo systemctl start conduit && \
	    sudo systemctl status conduit
    ;;
    'gotosocial')
	file="gotosocial_${VERSION}_linux_amd64.tar.gz"
	wget "https://codeberg.org/superseriousbusiness/gotosocial/releases/download/v$VERSION/$file"
	verify "$file"
	tar tvzf "$file"
	rm "$file"
	directory="$(basename -s .tar.gz "$file")"
	backup="$BACKUPS/$PACKAGE"
	mkdir -p "$backup"
	tree \
	   "$directory" \
	   "$backup"
	exit 42
	sudo cp -i '/usr/bin/gotosocial' "$backup/" && \
	    sudo systemctl stop gotosocial && \
	    sudo cp -f "$directory/gotosocial" '/usr/bin/gotosocial' && \
	    sudo mv -i '/var/lib/gotosocial/arkanosis.net/web' "$backup/" && \
	    sudo -u gotosocial cp -a "$directory/web" '/var/lib/gotosocial/arkanosis.net/' && \
	    sudo cp -i '/var/lib/gotosocial/arkanosis.net/sqlite.db' "$backup/sqlite.db" && \
	    sudo systemctl start gotosocial && \
	    sudo systemctl status gotosocial
    ;;
    'nebula')
	file="nebula-linux-amd64.tar.gz"
	wget "https://github.com/slackhq/nebula/releases/download/v$VERSION/$file"
	verify "$file"
	tar tvzf "$file"
	rm "$file"
	directory="$(basename -s .tar.gz "$file")"
	backup="$BACKUPS/$PACKAGE"
	mkdir -p "$backup"
	tree \
	   "$directory" \
	   "$backup"
	exit 42
	sudo cp -i '/usr/bin/nebula' "$backup/" && \
	    sudo systemctl stop nebula && \
	    sudo cp -f "$directory/nebula" '/usr/bin/nebula' && \
	    sudo systemctl start nebula && \
	    sudo systemctl status nebula
    ;;
    'ntfy')
	file="ntfy_${VERSION}_linux_amd64.tar.gz"
	wget "https://github.com/binwiederhier/ntfy/releases/download/v$VERSION/$file"
	verify "$file"
	tar tvzf "$file"
	rm "$file"
	directory="$(basename -s .tar.gz "$file")"
	backup="$BACKUPS/$PACKAGE"
	mkdir -p "$backup"
	tree \
	   "$directory" \
	   "$backup"
	exit 42
	sudo cp -i '/usr/bin/ntfy' "$backup/" && \
	    sudo systemctl stop ntfy && \
	    sudo cp -f "$directory/ntfy" '/usr/bin/ntfy' && \
	    sudo systemctl start ntfy && \
	    sudo systemctl status ntfy
    ;;
    *)
	echo "Unknown package '$PACKAGE'" >&2
	exit 1
    ;;
esac

echo "Finished upgrading '$PACKAGE' to version $VERSION"

(
    echo "Start: $START"
    echo "End: $(date)"
    echo "Package: $PACKAGE"
    echo "Version: $VERSION"
) | mail -Sttycharset=utf8 -s "Mise à jour de $PACKAGE en version $VERSION effectuée avec succès" arkanosis@gmail.com
