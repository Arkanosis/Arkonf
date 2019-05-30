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
    - watch:
      - file: /etc/nginx/nginx.conf # TODO also watch all sites-available confs
    - require:
      - pkg: server_pkgs

/etc/nginx/nginx.conf:
  file.managed:
    - makedirs: True
    - source: salt://server/nginx.conf
    - mode: 644

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

# TODO clone sites configuration
# TODO clone sites content
# TODO create symlinks in sites-available
