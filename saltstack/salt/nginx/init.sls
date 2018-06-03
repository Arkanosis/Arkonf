nginx_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] != 'Arch' %}
      - nginx
{% else %}
      - nginx-mainline
{% endif %}

nginx:
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/sites-available/userweb
      - file: /etc/nginx/sites-enabled/userweb
      - cmd: /etc/nginx/ssl/localhost.key
      - cmd: /etc/nginx/ssl/localhost.crt
    - require:
      - pkg: nginx_pkgs

/etc/nginx/sites-available/default:
  file:
    - absent
    - require:
      - pkg: nginx_pkgs

/etc/nginx/sites-enabled/default:
  file:
    - absent
    - require:
      - pkg: nginx_pkgs

/etc/nginx/sites-available/userweb:
  file.managed:
    - makedirs: True
    - source: salt://nginx/userweb
    - mode: 644
    - require:
      - pkg: nginx_pkgs

/etc/nginx/sites-enabled/userweb:
  file.symlink:
    - makedirs: True
    - target: /etc/nginx/sites-available/userweb
    - require:
      - pkg: nginx_pkgs

/etc/nginx/ssl:
  file.directory:
    - require:
      - pkg: nginx_pkgs

/etc/nginx/ssl/localhost.key:
  cmd.run:
    - name: openssl genrsa -out /etc/nginx/ssl/localhost.key 2048
    - require:
      - file: /etc/nginx/ssl
    - unless: test -f /etc/nginx/ssl/localhost.key

/etc/nginx/ssl/localhost.csr:
  cmd.wait:
    - name: openssl req -new -subj "/C=FR/O=arkanosis.net/CN=arkanosis.net/emailAddress=jroquet@arkanosis.net" -key /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.csr
    - watch:
      - cmd: /etc/nginx/ssl/localhost.key

/etc/nginx/ssl/localhost.crt:
  cmd.wait:
    - name: openssl x509 -req -in /etc/nginx/ssl/localhost.csr -signkey /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt
    - watch:
      - cmd: /etc/nginx/ssl/localhost.key
      - cmd: /etc/nginx/ssl/localhost.csr
