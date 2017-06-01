backup_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - ddrescue
{% else %}
      - gddrescue
{% endif %}
      - rsnapshot

/etc/rsnapshot.conf:
  file:
    - absent

/etc/rsnapshot.localhost.conf:
  file.managed:
    - source: salt://backup/rsnapshot.localhost.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.Neptune.conf:
  file.managed:
    - source: salt://backup/rsnapshot.Neptune.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.Poseidon.conf:
  file.managed:
    - source: salt://backup/rsnapshot.Poseidon.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.Typhon.conf:
  file.managed:
    - source: salt://backup/rsnapshot.Typhon.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.exclude:
  file.managed:
    - source: salt://backup/rsnapshot.exclude
    - template: jinja
    - mode: 644
