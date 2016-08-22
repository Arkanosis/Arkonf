xorg_pkgs:
  pkg.installed:
    - pkgs:
      - wmctrl
{% if grains['os_family'] == 'Arch' %}
      - xautolock
      - xorg-server
      - xorg-xinit
      - xorg-xinput
      - xorg-xrandr
{% else %}
      - xpra # TODO FIXME need it for ArchLinux as well
{% endif %}

# AUR sxlock

{% if grains['os_family'] == 'Arch' %}
/etc/systemd/system/sxlock.service:
  file.managed:
    - source: salt://xorg/sxlock.service
    - mode: 644
{% endif %}

/home/arkanosis/.xinitrc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/xorg/.xinitrc
    - user: arkanosis

/home/arkanosis/.Xmodmap:
  file.symlink:
    - target: /home/arkanosis/Arkonf/xorg/.Xmodmap
    - user: arkanosis

/home/arkanosis/.Xresources:
  file.symlink:
    - target: /home/arkanosis/Arkonf/xorg/.Xresources
    - user: arkanosis

