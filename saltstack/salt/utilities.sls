utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - exa
{% else %}
      - lsb
{% endif %}
      - lsb-release
{% if grains['os_family'] == 'Arch' %}
      - man-db
{% else %}
      - man
{% endif %}
      - moreutils
      - neofetch
      - parallel
      - tree
      - typespeed

# TODO install / compile csvfix
