include:
  - vcs

etckeeper_pkgs:
  pkg.installed:
    - pkgs:
      - etckeeper
    - require:
      - pkg: git_pkgs

/etc/etckeeper/etckeeper.conf:
  file.managed:
{% if grains['os_family'] == 'Arch' %}  
    - source: salt://etckeeper/etckeeper.arch.conf
{% else %}
    - source: salt://etckeeper/etckeeper.debian.conf
{% endif %}
    - mode: 644

etckeeper init && etckeeper commit -m 'Initial commit':
  cmd.run:
    - require:
      - pkg: etckeeper_pkgs
      - file: /etc/etckeeper/etckeeper.conf
    - unless: test -d /etc/.git
