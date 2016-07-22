mercurial_pkgs:
  pkg.installed:
    - pkgs:
      - mercurial

/home/arkanosis/.hgrc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/mercurial/.hgrc
    - user: arkanosis
