rsnapshot:
  pkg:
    - latest

/etc/rsnapshot.conf:
  file.managed:
    - source: salt://backup/rsnapshot.conf
    - template: jinja
    - mode: 644
