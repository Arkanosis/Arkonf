image_pkgs:
  pkg.installed:
    - pkgs:
      - blender
      - darktable
{% if grains['os_family'] != 'Arch' %}
      - exiftran
{% else %}
      - fbida # provides exiftran
{% endif %}
      - jhead
      - gimp
      - gimp-help-fr
{% if grains['os_family'] != 'Arch' %}
      - gimp-plugin-registry
{% endif %}
      - graphviz
      - gwenview
      - hugin
      - imagemagick
      - inkscape
{% if grains['os_family'] != 'Arch' %}
      - kipi-plugins
{% endif %}
      - maim
      - rawtherapee
      - sxiv
