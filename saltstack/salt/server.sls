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

      - sudo

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

{% for user in pillar['users'] %}

{% if user.login in pillar['local_users'] %}

{{ user.login }}:
  user.present:
    - fullname: {{ user.fullname | default('') }}
    - home: /home/{{ user.login }}
    - shell: {{ user.shell | default('/bin/bash') }}
    - system: {{ user.system | default(False) }}
    - uid: {{ user.id }}
    - gid: {{ user.id }}
{% if user.sudo | default(False) %}
    - groups:
      - sudo
{% endif %}
# TODO handle groups
    - remove_groups: False
    - require:
      - group: {{ user.login }}
  group.present:
    - gid: {{ user.id }}

/home/{{ user.login }}/.ssh/authorized_keys:
  file.managed:
    - contents: {{ user.authorized_keys | default('') | yaml_encode }}
    - user: {{ user.login }}
    - group: {{ user.login }}
    - mode: 644
    - makedirs: True
    - require:
      - user: {{ user.login }}

{% if user.linger | default(False) %}
/var/lib/systemd/linger/{{ user.login }}:
  file.managed:
    - makedirs: True
{% endif %}

{% if user.arkonf | default(False) %}
{{ user.login }}_arkonf:
  git.latest:
    - name: https://github.com/Arkanosis/Arkonf.git
    - rev: master
    - target: /home/{{ user.login }}/Arkonf
    - user: {{ user.login }}
    - unless: test -d /home/{{ user.login }}/Arkonf

rm -f /home/{{ user.login }}/.bashrc:
  cmd.run:
    - require:
      - user: {{ user.login }}
    - unless: test -f /home/{{ user.login }}/.zshrc

make -C /home/{{ user.login }}/Arkonf install:
  cmd.run:
    - require:
      - user: {{ user.login }}
    - runas: {{ user.login }}
    - unless: test -f /home/{{ user.login }}/.zshrc
{% endif %}

# TODO enable local override
#  - ssh for asdp on Bismuth
#  - linger for Daniel on Cyclamen and Bruyere
#  - linger for Simonne on Bruyere
#  - authorized_keys rssht-user

{% endif %}

{% endfor %}
