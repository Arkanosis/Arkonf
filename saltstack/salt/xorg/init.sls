xorg_pkgs:
  pkg.installed:
    - pkgs:
      - sxhkd
      - synergy
{% if grains['os_family'] == 'Arch' %}
      - tigervnc
{% else %}
      - tightvncserver
      - xtightvncviewer
{% endif %}
      - wmctrl
      - x11vnc
      - xdotool
      - xpra
      - xsel
{% if grains['os_family'] == 'Arch' %}
      - xautolock
      - xorg-server
      - xorg-server-xephyr
      - xorg-xbacklight
      - xorg-xev
      - xorg-xinit
      - xorg-xinput
      - xorg-xprop
      - xorg-xrandr
      - xorg-xset
{% else %}
      - x11-utils
      - xbacklight
      - xserver-xephyr
{% endif %}

# AUR sxlock

{% if grains['os_family'] == 'Arch' %}
/etc/systemd/system/sxlock.service:
  file.managed:
    - source: salt://xorg/sxlock.service
    - mode: 644
{% endif %}
