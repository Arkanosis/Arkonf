include:
  - repos

server_pkgs:
  pkg.installed:
    - pkgs:
      - curl
      - rsync

      - ntp

      - goaccess

      - nginx
      - nginx-extras

      - sudo

      - make

server_pkgs_extras:
  pkg.installed:
    - pkgs:
      - certbot
      - python-certbot-nginx
    - fromrepo: stretch-backports

{% if pillar['domains'] %}

# TODO clone site configurations in sites-available based on domains

# TODO enable sites based on domains
/etc/nginx/sites-enabled/bismuth.arkanosis.net:
  file.symlink:
    - makedirs: True
    - target: ../sites-available/bismuth.arkanosis.net

certbot run --non-interactive --agree-tos --email {{ pillar['recipient_email'] }} --nginx --expand {% for domain in pillar['domains'] %} --domain {{ domain }} {% endfor %}:
  cmd.run:
    - unless: test -f /etc/letsencrypt/live/bismuth.arkanosis.net/fullchain.pem

{% endif %}

nginx:
  service.running:
    - enable: True
    - require:
      - pkg: server_pkgs

/etc/nginx/sites-available/default:
  file:
    - absent

/etc/nginx/sites-enabled/default:
  file:
    - absent

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

# TODO generate and install nginx letsencrypt certificates
# TODO auto-renew certificates
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

{% if user.sftp | default(False) %}
/var/sftp/{{ user.login }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/var/sftp/{{ user.login }}/incoming:
  file.directory:
    - user: {{ user.login }}
    - group: {{ user.login }}
    - mode: 700
{% endif %}

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

{% endif %}

{% endfor %}

/root/.ssh/authorized_keys:
  file.managed:
    - contents: {{ pillar['users'][0].authorized_keys | default('') | yaml_encode }}
    - mode: 644
    - makedirs: True

# TODO clone sites configuration
# TODO clone sites content
# TODO create symlinks in sites-available
