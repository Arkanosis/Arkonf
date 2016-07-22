touchpad_pkgs:
  pkg.installed:
    - pkgs:
      - xf86-input-synaptics

/etc/X11/xorg.conf.d/70-synaptics.conf:
  file.managed:
    - source: salt://touchpad/70-synaptics.conf
    - mode: 644
