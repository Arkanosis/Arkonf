utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
      - exa
{% endif %}
      - hexyl
      - kdialog
      - lsb-release
{% if grains['os_family'] == 'Arch' %}
      - man-db
{% endif %}
      - mlocate
      - moreutils
      - neofetch
      - parallel
{% if grains['os_family'] == 'Arch' %}
      - pueue
{% else %}
      - sysvbanner
{% endif %}
      - tree
      - typespeed

# TODO install / compile csvfix
