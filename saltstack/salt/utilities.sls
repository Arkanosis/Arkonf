utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - exa
{% endif %}
      - lsb
      - lsb-release
      - man
      - moreutils
      - neofetch
      - parallel
      - tree
      - typespeed

# TODO install / compile csvfix
