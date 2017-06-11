network_pkgs:
  pkg.installed:
    - pkgs:
      - emacs
      - vim

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

/home/arkanosis/.vimrc:
  file.symlink:
    - target: /home/arkanosis/Arkonf/vim/.vimrc
    - user: arkanosis

/home/arkanosis/.vim:
  file.symlink:
    - target: /home/arkanosis/Arkonf/vim/.vim
    - user: arkanosis
