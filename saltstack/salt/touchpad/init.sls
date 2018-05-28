touchpad_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - xf86-input-synaptics
{% else %}
      - xserver-xorg-input-synaptics
{% endif %}

/etc/X11/xorg.conf.d/70-synaptics.conf:
  file.managed:
    - makedirs: True
    - source: salt://touchpad/70-synaptics.conf
    - mode: 644
