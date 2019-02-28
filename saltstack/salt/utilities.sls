utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - exa
{% endif %}
      - lsb
      - lsb-release
      - moreutils
      - neofetch
      - parallel
      - tree
      - typespeed

# TODO install / compile csvfix
