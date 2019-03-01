include:
  - repos

server_pkgs:
  pkg.installed:
    - pkgs:
      - curl
      - rsync

      - s-nail
      - ssmtp

      - ntp

      - goaccess

      - nginx
      - nginx-extras

      - tmux

      - make

server_pkgs_extras:
  pkg.installed:
    - pkgs:
      - certbot
    - fromrepo: stretch-backports

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf
    - mode: 640

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - mode: 640

ntp:
  service.running:
    - enable: True
    - require:
      - pkg: server_pkgs

# /etc/hostname:
#   file.managed:
#     - source: salt://hostname
#     - user: root
#     - mode: 644

# /etc/hosts:
#   file.managed:
#     - source: salt://hosts
#     - user: root
#     - mode: 644

# /etc/cron.daily/certbot:
#   file.managed:
#     - source: salt://webservers/certbot-cron
#     - mode: 755

arkanosis:
  user.present:
    - home: /home/arkanosis
    - shell: /bin/bash
    - uid: 1000
    - gid: 1000
    - remove_groups: False
    - require:
      - group: arkanosis
  group.present:
    - gid: 1000
