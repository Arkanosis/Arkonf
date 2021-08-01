{% if grains['oscodename'] == 'buster' %}

/etc/apt/preferences:
  file.managed:
    - source: salt://repos/apt-preferences
    - mode: 644

# TODO FIXME personal apt repository for packages missing in Debian Buster

deb http://deb.debian.org/debian buster contrib:
  pkgrepo.managed:
    - dist: buster
    - file: /etc/apt/sources.list.d/contrib.list

deb http://deb.debian.org/debian buster non-free:
  pkgrepo.managed:
    - dist: buster
    - file: /etc/apt/sources.list.d/non-free.list

deb http://ftp.debian.org/debian buster-backports main:
  pkgrepo.managed:
    - dist: buster-backports
    - file: /etc/apt/sources.list.d/backports.list

deb http://security.debian.org/ buster/updates main:
  pkgrepo.managed:
    - dist: buster/updates
    - file: /etc/apt/sources.list.d/security.list

{% elif grains['os_family'] == 'Arch' %}

# TODO FIXME personal pkg repository for packages missing in Arch

{% endif %}
