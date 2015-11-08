etckeeper:
  pkg:
    - latest
    - require:
      - pkg: git

/etc/etckeeper/etckeeper.conf:
  file.managed:
    - source: salt://etckeeper/etckeeper.conf
    - mode: 644

etckeeper init && etckeeper commit -m 'Initial commit':
  cmd.run:
    - require:
      - pkg: etckeeper
      - file: /etc/etckeeper/etckeeper.conf
    - unless: test -d /etc/.git
