# Arkonf

Arkonf is a system configuration including:
* a list of packages to install, managed using Salt;
* a collection of configuration files for these tools.

## Installation

## As regular user on any POSIX OS

This will only install configuration files for the current user.

```sh
git clone https://github.com/Arkanosis/Arkonf.git
make -C Arkonf install
```

## As root

This is the prefered way to install the full Arkonf (including packages).

### On Arch Linux

```sh
pacman -S salt openssh openbsd-netcat git
git clone https://github.com/Arkanosis/Arkonf.git /root/Arkonf
ln -s /root/Arkonf/saltstack/salt /srv/salt
ln -s /root/Arkonf/saltstack/pillar /srv/pillar
salt-call --local state.highstate
pacman -Syu
```

### On Debian and Kubuntu

```sh
apt install salt-minion git
git clone https://github.com/Arkanosis/Arkonf.git /root/Arkonf
ln -s /root/Arkonf/saltstack/salt /srv/salt
ln -s /root/Arkonf/saltstack/pillar /srv/pillar
apt update
salt-call --local state.highstate
apt upgrade
```

## Copyright

Arkonf is copyright (C) 2001-2018 Jérémie Roquet <jroquet@arkanosis.net> and
all code except code written by third-parties licensed under the ISC license.

See the [LICENSE](/LICENSE) file for more details.

## Links

* https://arkanosis.net/
* https://github.com/Arkanosis/Arkonf
