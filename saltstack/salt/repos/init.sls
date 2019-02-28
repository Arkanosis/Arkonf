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

{% endif %}
