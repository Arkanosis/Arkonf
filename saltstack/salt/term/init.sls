rxvt-unicode-256color:
  pkg:
    - latest

tmux:
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

