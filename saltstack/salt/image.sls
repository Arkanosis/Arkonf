image_pkgs:
  pkg.installed:
    - pkgs:
      - darktable
      - jhead
      - gimp
      - gimp-help-fr
{% if grains['os_family'] != 'Arch' %}
      - gimp-plugin-registry
{% endif %}
      - hugin
      - imagemagick
      - inkscape
{% if grains['os_family'] != 'Arch' %}
      - kipi-plugins
{% endif %}
      - rawtherapee
