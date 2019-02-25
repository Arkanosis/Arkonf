{% if grains['oscodename'] == 'stretch' %}
deb http://deb.debian.org/debian stretch contrib:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/contrib.list

deb http://deb.debian.org/debian stretch non-free:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/non-free.list
{% endif %}
