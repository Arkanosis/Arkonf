openssh-server:
  pkg:
    - latest

/home/arkanosis/.ssh/config:
  file.symlink:
    - target: /home/arkanosis/Arkonf/ssh/.ssh/config
    - user: arkanosis

