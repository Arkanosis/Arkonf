nginx:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/nginx/sites-available/userweb
      - file: /etc/nginx/sites-enabled/userweb
      - cmd: /etc/nginx/ssl/taz-localhost.key
      - cmd: /etc/nginx/ssl/taz-localhost.crt
    - require:
      - pkg: nginx

/etc/nginx/sites-available/default:
  file:
    - absent
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file:
    - absent
    - require:
      - pkg: nginx

/etc/nginx/sites-available/userweb:
  file.managed:
    - source: salt://nginx/userweb
    - mode: 644
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/userweb:
  file.symlink:
    - target: /etc/nginx/sites-available/userweb
    - require:
      - pkg: nginx

/etc/nginx/ssl:
  file.directory:
    - require:
      - pkg: nginx

/etc/nginx/ssl/taz-localhost.key:
  cmd.run:
    - name: openssl genrsa -out /etc/nginx/ssl/taz-localhost.key 2048
    - require:
      - file: /etc/nginx/ssl
    - unless: test -f /etc/nginx/ssl/taz-localhost.key

/etc/nginx/ssl/taz-localhost.csr:
  cmd.wait:
    - name: openssl req -new -subj "/C=FR/O=arkanosis.net/CN=arkanosis.net/emailAddress=jroquet@arkanosis.net" -key /etc/nginx/ssl/taz-localhost.key -out /etc/nginx/ssl/taz-localhost.csr
    - watch:
      - cmd: /etc/nginx/ssl/taz-localhost.key

/etc/nginx/ssl/taz-localhost.crt:
  cmd.wait:
    - name: openssl x509 -req -in /etc/nginx/ssl/taz-localhost.csr -signkey /etc/nginx/ssl/taz-localhost.key -out /etc/nginx/ssl/taz-localhost.crt
    - watch:
      - cmd: /etc/nginx/ssl/taz-localhost.key
      - cmd: /etc/nginx/ssl/taz-localhost.csr
