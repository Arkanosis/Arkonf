term_pkgs:
  pkg.installed:
    - pkgs:
      - reptyr
{% if grains['os_family'] == 'Arch' %}
      - rxvt-unicode
{% else %}
      - rxvt-unicode-256color
{% endif %}
      - tmux
{% if grains['os_family'] != 'Arch' %}
      - yakuake
{% endif %}

/usr/bin/zmux:
  file.managed:
    - source: salt://term/zmux
    - mode: 755

/usr/bin/zssh:
  file.managed:
    - source: salt://term/zssh
    - mode: 755
