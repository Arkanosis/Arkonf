utilities_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
      - broot
      - eza
{% else %}
      - sysvbanner
      - exa
{% endif %}
      - fzf
      - hexyl
      - kdialog
      - inotify-tools
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
      - xdg-user-dirs
{% if grains['os_family'] == 'Arch' %}
      - zoxide
{% endif %}

# TODO install / compile csvfix
