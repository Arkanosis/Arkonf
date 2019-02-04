xorg_pkgs:
  pkg.installed:
    - pkgs:
      - sxhkd
{% if grains['os_family'] == 'Arch' %}
      - tigervnc
{% else %}
      - tightvncserver
      - xtightvncviewer
{% endif %}
      - wmctrl
      - x11vnc
      - xdotool
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
{% else %}
      - x11-utils
      - xbacklight
      - xpra # TODO FIXME need it for ArchLinux as well
      - xserver-xephyr
{% endif %}

# AUR sxlock

{% if grains['os_family'] == 'Arch' %}
/etc/systemd/system/sxlock.service:
  file.managed:
    - source: salt://xorg/sxlock.service
    - mode: 644
{% endif %}
