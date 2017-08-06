backup_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - ddrescue
{% else %}
      - gddrescue
{% endif %}
      - rsnapshot

{% if grains['host'] == 'Cyclamen' %}
/usr/bin/sauvegarde:
  file.managed:
    - source: salt://backup/sauvegarde
    - template: jinja
    - mode: 755 # TODO FIXME group

# TODO
# - sudo ALL for /usr/bin/sauvegarde
# - /mnt/Heimdal in /etc/fstab
# - Wrapper for /usr/bin/sauvegarde (in /home/Daniel/Documents/sauvegarde)
{% endif %}

/etc/rsnapshot.conf:
  file:
    - absent

/etc/rsnapshot.localhost.conf:
  file.managed:
    - source: salt://backup/rsnapshot.localhost.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.Heimdal.conf:
  file.managed:
    - source: salt://backup/rsnapshot.Heimdal.conf
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
