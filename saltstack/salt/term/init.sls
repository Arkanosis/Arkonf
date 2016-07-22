term_pkgs:
  pkg.installed:
    - pkgs:
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

/home/arkanosis/.tmux.conf:
  file.symlink:
    - target: /home/arkanosis/Arkonf/tmux/.tmux.conf
    - user: arkanosis

/home/arkanosis/.screenrc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/screen/.screenrc
    - user: arkanosis

/home/arkanosis/.kde/share/config/yakuakerc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/yakuake/yakuakerc
    - user: arkanosis
