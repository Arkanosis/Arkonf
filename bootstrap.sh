#! /bin/sh

bootstrap() {
    if grep -qi 'ubuntu\|debian' /etc/os-release; then
	apt install -y salt-minion git
	git clone https://github.com/Arkanosis/Arkonf.git /root/Arkonf
	ln -s /root/Arkonf/saltstack/salt /srv/salt
	ln -s /root/Arkonf/saltstack/pillar /srv/pillar
	apt update
	salt-call --local state.highstate
	apt upgrade -y
    elif grep -qi 'arch linux' /etc/os-release; then
	pacman -S --noconfirm salt git
	git clone https://github.com/Arkanosis/Arkonf.git /root/Arkonf
	ln -s /root/Arkonf/saltstack/salt /srv/salt
	ln -s /root/Arkonf/saltstack/pillar /srv/pillar
	salt-call --local state.highstate
	pacman -Syu --noconfirm
    else
	echo 'Unknown operating system' >&2
	exit 1
    fi
}

bootstrap
