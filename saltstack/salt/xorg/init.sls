xorg_pkgs:
  pkg.installed:
    - pkgs:
      - barrier
      - brightnessctl
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
      - xpra
      - xsel
      - xautolock
{% if grains['os_family'] == 'Arch' %}
      - xf86-input-wacom
      - xorg-fonts-misc
      - xorg-server
      - xorg-server-xephyr
      - xorg-xev
      - xorg-xinit
      - xorg-xinput
      - xorg-xprop
      - xorg-xrandr
      - xorg-xset
{% else %}
      - x11-utils
      - x11-xserver-utils
      - xinit
      - xinput
      - xserver-xephyr
      - xserver-xorg-core
      - xserver-xorg-input-evdev
      - xserver-xorg-input-wacom
{% endif %}

# AUR sxlock

/etc/X11/Xwrapper.config:
  file.managed:
    - contents:
{% if grains['os_family'] == 'Arch' %}
        - needs_root_rights = no
{% else %}
        - allowed_users = console
{% endif %}

/etc/systemd/system/sxlock.service:
  file.managed:
    - source: salt://xorg/sxlock.service
    - mode: 644

{% if grains['os_family'] == 'Debian' %}

/etc/sddm.conf:
  file.managed:
    - source: salt://xorg/sddm.conf
    - mode: 644

{% endif %}