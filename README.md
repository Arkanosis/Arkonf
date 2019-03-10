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

Before anything else, the host name must be set properly. All hosts will get
the base packages and configuration, but only some hosts will get additional
packages, depending on which roles are associated to their names in the pillar.

```sh
hostnamectl set-hostname $HOSTNAME
```

Also, make sure that the name (and the FQDN) is correct in `/etc/hosts` as it
will be used by some packages (such as the MTA).

### On Arch Linux

```sh
pacman -S salt git
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

## Application of individual states

Individual states may rely on custom grains and custom modules, which
must be synchronized.

```sh
salt-call --local state.highstate saltutil.sync_all
```

Afterwards, indidual states can be applied.

```sh
salt-call --local state.sls mail
```

Synchronization of custom grains and custom modules is done automatically when
running`state.highstate`, so there's no need to run `saltutil.sync_all` when
applying the highstate.

## Copyright

Arkonf is copyright (C) 2001-2019 Jérémie Roquet <jroquet@arkanosis.net> and
all code except code written by third-parties licensed under the ISC license.

See the [LICENSE](/LICENSE) file for more details.

## Links

* https://arkanosis.net/
* https://github.com/Arkanosis/Arkonf
