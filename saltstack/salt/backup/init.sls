include:
  - users

backup_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - borg
      - ddrescue
{% else %}
      - borgbackup
      - gddrescue
{% endif %}
      # - TODO duplicati
      - restic
{% if grains['os_family'] != 'Debian' %}
      - rsnapshot
{% endif %}
      - syncthing
      - testdisk

# AUR restic-rest-server

{% if grains['host'] == 'Cyclamen' %}
/usr/bin/sauvegarde:
  file.managed:
    - source: salt://backup/usr_bin_sauvegarde
    - template: jinja
    - mode: 755

/home/Daniel/Documents/sauvegarde:
  file.managed:
    - source: salt://backup/home_daniel_documents_sauvegarde
    - template: jinja
    - user: Daniel
    - group: Daniel
    - mode: 755

/mnt/Heimdal:
  mount.mounted:
    - device: UUID=e4e07b31-a0c4-44c6-909f-3e6836f543b0
    - fstype: ext4
    - mkmnt: True
    - mount: False
    - opts:
      - noauto
      - nodev
      - nosuid

/etc/sudoers.d/sauvegarde:
  file.managed:
    - makedirs: True
    - source: salt://backup/sauvegarde_sudoers
    - user: root
    - group: root
    - mode: 440
    - check-cmd: /usr/sbin/visudo -c -f
    - require:
      - pkg: users_pkgs

{% endif %}

/etc/rsnapshot.conf:
  file:
    - absent

/etc/rsnapshot.localhost.conf:
  file.managed:
    - source: salt://backup/rsnapshot.localhost.conf
    - template: jinja
    - mode: 644

/etc/rsnapshot.Aegir.conf:
  file.managed:
    - source: salt://backup/rsnapshot.Aegir.conf
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

{% if grains['host'] == 'gossamer' %}
/home/borgbackup/backups/bismuth:
  file.directory:
    - user: borgbackup
    - group: borgbackup
    - mode: 700
    - makedirs: True
{% endif %}

{% if grains['host'] == 'bismuth' %}
/usr/bin/hadduck:
  file.managed:
    - source: salt://backup/usr_bin_hadduck
    - mode: 755

# TODO put the exclude file in /etc instead
/usr/bin/hadduck.exclude:
  file.managed:
    - source: salt://backup/hadduck.exclude
    - mode: 644

/usr/lib/systemd/system/hadduck@.service:
  file.managed:
    - source: salt://backup/hadduck@.service
    - mode: 644

/usr/lib/systemd/system/hadduck@.timer:
  file.managed:
    - source: salt://backup/hadduck@.timer
    - mode: 644

hadduck@@Edelweiss.nebula.timer:
  service.running:
    - enable: True
{% endif %}

# TODO duplicati user service for Sandrine
