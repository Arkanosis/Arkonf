pacman_pkgs:
  pkg.installed:
    - pkgs:
      - base-devel
      - pacman-contrib

# AUR yay

/etc/pacman.conf:
  file.managed:
    - source: salt://pacman/pacman.conf
    - mode: 644
