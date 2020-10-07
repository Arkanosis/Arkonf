pacman_pkgs:
  pkg.installed:
    - pkgs:
      - pacman-contrib

pacman_pkgs_group:
  pkg.group_installed:
    - name:
      - base-devel

# AUR yay

/etc/pacman.conf:
  file.managed:
    - source: salt://pacman/pacman.conf
    - mode: 644
