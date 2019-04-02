{% if grains['oscodename'] == 'stretch' %}

/etc/apt/preferences:
  file.managed:
    - source: salt://repos/apt-preferences
    - mode: 644

deb http://deb.debian.org/debian stretch contrib:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/contrib.list

deb http://deb.debian.org/debian stretch non-free:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/non-free.list

deb http://ftp.debian.org/debian stretch-backports main:
  pkgrepo.managed:
    - dist: stretch-backports
    - file: /etc/apt/sources.list.d/backports.list

deb http://security.debian.org/ stretch/updates main:
  pkgrepo.managed:
    - dist: stretch/updates
    - file: /etc/apt/sources.list.d/security.list

{% elif grains['oscodename'] == 'xenial' %}

deb http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu xenial main:
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/graphics-drivers.list

deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main:
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/wine.list

deb http://ppa.launchpad.net/lutris-team/lutris/ubuntu xenial main:
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/lutris.list

deb http://repo.steampowered.com/steam/precise main:
  pkgrepo.managed:
    - dist: precise
    - file: /etc/apt/sources.list.d/steam.list

{% endif %}
