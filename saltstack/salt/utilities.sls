utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
      - exa
      - hexyl # TODO FIXME need it for Debian / Kubuntu as well
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
{% if grains['os_family'] != 'Arch' %}
      - sysvbanner
{% endif %}
      - tree
      - typespeed

# TODO install / compile csvfix
