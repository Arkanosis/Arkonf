utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
      - exa
{% endif %}
{% if grains['oscodename'] not in ['xenial', 'bionic'] %}
      - hexyl
{% endif %}
{% if grains['os_family'] != 'Arch' %}
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
