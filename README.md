# Arkonf

Arkonf is system configuration including:
* a list of packages to install, managed using Salt;
* a collection of configuration files for these tools.

## Installation

## As regular user on any POSIX OS

This will only install configuration files for the current user.

```
cd
git clone https://github.com/Arkanosis/Arkonf.git
cd Arkonf
./install.sh
```

## As root

This is the prefered way to install the full Arkonf (including packages) on a
machine with sudo access.

### On Arch Linux

```
pacman -S salt-raet openssh openbsd-netcat git
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

### On Kubuntu

```
apt-get install salt-minion
ssh-keygen -t rsa -b 4096
< /root/.ssh/id_rsa.pub nc termbin.com 9999
# Add your public key on GitHub
cd /root
git clone git@github.com:Arkanosis/Arkonf.git
ln -s /root/Arkonf/saltstack /srv
sed -i 's/.*file_client:.*/file_client: local/' /etc/salt/minion
salt-call state.highstate
aptitude update && aptitude full-upgrade
```

## Copyright

Copyright 2001-2015 – Jérémie Roquet <jroquet@arkanosis.net>

All code except code written by third-parties released under the MIT License.

## Links

* http://arkanosis.net/
* http://github.com/Arkanosis/Arkonf
