xorg_pkgs:
  pkg.installed:
    - pkgs:
      - wmctrl
{% if grains['os_family'] == 'Arch' %}
      - xorg-server
      - xorg-xinit
{% endif %}

# TODO FIXME ~/.xinitrc

/home/arkanosis/.Xmodmap:
  file.symlink:
    - target: /home/arkanosis/Arkonf/xorg/.Xmodmap
    - user: arkanosis

/home/arkanosis/.Xresources:
  file.symlink:
    - target: /home/arkanosis/Arkonf/xorg/.Xresources
    - user: arkanosis
