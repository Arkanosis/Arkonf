# TODO generate ssh keys

openssh-server:
  pkg:
    - latest

sshfs:
  pkg:
    - latest

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - mode: 644

/home/arkanosis/.ssh/config:
  file.symlink:
    - target: /home/arkanosis/Arkonf/ssh/.ssh/config
    - user: arkanosis
