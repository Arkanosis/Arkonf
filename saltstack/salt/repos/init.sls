{% if grains['oscodename'] == 'bullseye' %}

/etc/apt/preferences:
  file.managed:
    - source: salt://repos/apt-preferences
    - mode: 644

# TODO FIXME personal apt repository for packages missing in Debian Bullseye

deb http://deb.debian.org/debian bullseye contrib:
  pkgrepo.managed:
    - dist: bullseye
    - file: /etc/apt/sources.list.d/contrib.list

deb http://deb.debian.org/debian bullseye non-free:
  pkgrepo.managed:
    - dist: bullseye
    - file: /etc/apt/sources.list.d/non-free.list

deb http://ftp.debian.org/debian bullseye-backports main:
  pkgrepo.managed:
    - dist: bullseye-backports
    - file: /etc/apt/sources.list.d/backports.list

deb http://security.debian.org/ bullseye-security main:
  pkgrepo.managed:
    - dist: bullseye-security
    - file: /etc/apt/sources.list.d/security.list

{% elif grains['os_family'] == 'Arch' %}

# TODO FIXME personal pkg repository for packages missing in Arch

{% endif %}
