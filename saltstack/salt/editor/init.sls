editor_pkgs:
  pkg.installed:
    - pkgs:
      - bat
      - dhex
      - emacs
{% if grains['os_family'] == 'Arch' %}
      - jless
{% endif %}
      - vim

editor_pkgs_removed: # https://github.com/saltstack/salt/issues/35592
  pkg.removed:
    - pkgs:
      - nano

/usr/bin/emacs-console:
  file.managed:
    - source: salt://editor/emacs-console
    - mode: 755

/usr/bin/org-console:
  file.managed:
    - source: salt://editor/org-console
    - mode: 755
