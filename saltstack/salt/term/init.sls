rxvt-unicode-256color:
  pkg:
    - latest

tmux:
  pkg:
    - latest

yakuake:
  pkg:
    - latest

/usr/bin/zmux:
  file.managed:
    - source: salt://term/zmux
    - mode: 755

/usr/bin/zssh:
  file.managed:
    - source: salt://term/zssh
    - mode: 755

/home/arkanosis/.tmux.conf:
  file.symlink:
    - target: /home/arkanosis/Arkonf/tmux/.tmux.conf
    - user: arkanosis

/home/arkanosis/.screenrc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/screen/.screenrc
    - user: arkanosis

/home/arkanosis/.kde/share/config/yakuakerc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/yakuake/yakuakerc
    - user: arkanosis
