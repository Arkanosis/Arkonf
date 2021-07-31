image_pkgs:
  pkg.installed:
    - pkgs:
      - blender
      - darktable
{% if grains['os_family'] != 'Arch' %}
      - exiftran
      - freecad # TODO FIXME need it for ArchLinux as well
{% else %}
      - fbida # provides exiftran
{% endif %}
      - flameshot
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
      - jhead
{% if grains['os_family'] != 'Arch' %}
      - kipi-plugins
{% endif %}
      - maim
      - rawtherapee
      - sweethome3d
      - sxiv
