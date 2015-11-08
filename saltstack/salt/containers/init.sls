docker.io:
  pkg:
    - latest

lxc:
  pkg:
    - latest

/etc/lxc/lxc-usernet:
  file.managed:
    - source: salt://containers/lxc-usernet
    - mode: 644

/home/arkanosis/.config/lxc/default.conf:
  file.symlink:
    - target: /home/arkanosis/Arkonf/lxc/default.conf
    - user: arkanosis
    - makedirs: True
