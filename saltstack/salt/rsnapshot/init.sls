rsnapshot:
  pkg:
    - latest

/etc/rsnapshot.conf:
  file.managed:
    - source: salt://rsnapshot/rsnapshot.conf
    - mode: 644

