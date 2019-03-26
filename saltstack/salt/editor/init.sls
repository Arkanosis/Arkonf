editor_pkgs:
  pkg.installed:
    - pkgs:
      - dhex
      - emacs
      - vim

/usr/bin/emacs-console:
  file.managed:
    - source: salt://editor/emacs-console
    - mode: 755

/usr/bin/org-console:
  file.managed:
    - source: salt://editor/org-console
    - mode: 755
