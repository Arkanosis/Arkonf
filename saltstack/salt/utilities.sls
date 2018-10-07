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
      - typespeed

# TODO install / compile csvfix
