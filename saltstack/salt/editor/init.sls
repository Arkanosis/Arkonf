editor_pkgs:
  pkg.installed:
    - pkgs:
      - emacs
      - vim

/usr/bin/emacs-console:
  file.managed:
    - source: salt://editor/emacs-console
    - mode: 755

/usr/bin/emacs-client:
  file.managed:
    - source: salt://editor/emacs-client
    - mode: 755
