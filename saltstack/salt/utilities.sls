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

# TODO install / compile csvfix
