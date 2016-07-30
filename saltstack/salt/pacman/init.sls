pacman_pkgs:
  pkg.installed:
    - pkgs:
      - base-devel

# AUR cower
# AUR pacaur

/etc/pacman.conf:
  file.managed:
    - source: salt://pacman/pacman.conf
    - mode: 644
