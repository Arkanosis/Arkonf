{% if grains['oscodename'] == 'bookworm' %}

/etc/apt/preferences:
  file.managed:
    - source: salt://repos/apt-preferences
    - mode: 644

# TODO FIXME personal apt repository for packages missing in Debian Bookworm

deb http://deb.debian.org/debian bookworm contrib:
  pkgrepo.managed:
    - dist: bookworm
    - file: /etc/apt/sources.list.d/contrib.list

deb http://deb.debian.org/debian bookworm non-free:
  pkgrepo.managed:
    - dist: bookworm
    - file: /etc/apt/sources.list.d/non-free.list

deb http://ftp.debian.org/debian bookworm-backports main:
  pkgrepo.managed:
    - dist: bookworm-backports
    - file: /etc/apt/sources.list.d/backports.list

wget https://repo.saltproject.io/salt/py3/debian/11/amd64/latest/salt-archive-keyring.gpg -O /usr/share/keyrings/salt-archive-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/salt-archive-keyring.gpg

deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/11/amd64/latest bullseye main:
  pkgrepo.managed:
    - dist: bullseye
    - file: /etc/apt/sources.list.d/salt.list

wget https://syncthing.net/release-key.gpg -O /usr/share/keyrings/syncthing-archive-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/syncthing-archive-keyring.gpg

deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable:
  pkgrepo.managed:
    - dist: syncthing
    - file: /etc/apt/sources.list.d/syncthing.list

{% elif grains['os_family'] == 'Arch' %}

# TODO FIXME personal pkg repository for packages missing in Arch

{% endif %}
