utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - exa
{% endif %}
      - lsb
      - moreutils
      - parallel

# TODO install / compile csvfix
