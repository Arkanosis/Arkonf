emacs:
  pkg:
    - latest

/usr/bin/emacs-console:
  file.managed:
    - source: salt://emacs/emacs-console
    - mode: 755

/usr/bin/emacs-server:
  file.managed:
    - source: salt://emacs/emacs-server
    - mode: 755

/usr/bin/emacs-client:
  file.managed:
    - source: salt://emacs/emacs-client
    - mode: 755

/home/arkanosis/.emacs:
  file.symlink:
    - target: /home/arkanosis/Arkonf/emacs/.emacs
    - user: arkanosis

/home/arkanosis/.emacs.d:
  file.symlink:
    - target: /home/arkanosis/Arkonf/emacs/.emacs.d
    - user: arkanosis

