utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
      - broot
{% else %}
      - sysvbanner
{% endif %}
      - exa
      - hexyl
      - kdialog
      - lsb-release
      - man-db
      - mlocate
      - moreutils
      - neofetch
      - parallel
{% if grains['os_family'] == 'Arch' %}
      - pueue
      - systeroid
{% endif %}
      - tree
      - typespeed

# TODO install / compile csvfix
