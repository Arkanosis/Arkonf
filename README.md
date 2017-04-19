# Arkonf

Arkonf is system configuration including:
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
ssh-keygen -t rsa -b 4096
< /root/.ssh/id_rsa.pub nc termbin.com 9999
# Add your public key on GitHub
cd /root
git clone git@github.com:Arkanosis/Arkonf.git
ln -s /root/Arkonf/saltstack/salt /srv/salt
ln -s /root/Arkonf/saltstack/pillar /srv/pillar
salt-call --local state.highstate
pacman -Syu
```

### On Debian and Kubuntu

```sh
apt install salt-minion git
ssh-keygen -t rsa -b 4096
< /root/.ssh/id_rsa.pub nc termbin.com 9999
# Add your public key on GitHub
cd /root
git clone git@github.com:Arkanosis/Arkonf.git
ln -s /root/Arkonf/saltstack /srv
sed -i 's/.*file_client:.*/file_client: local/' /etc/salt/minion
apt update
salt-call state.highstate
apt upgrade
```

## Copyright

Copyright 2001-2017 – Jérémie Roquet <jroquet@arkanosis.net>

All code except code written by third-parties released under the MIT License.

See the `LICENSE` file for more details.

## Links

* https://arkanosis.net/
* https://github.com/Arkanosis/Arkonf
