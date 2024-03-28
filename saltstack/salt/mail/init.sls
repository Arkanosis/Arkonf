mail_pkgs:
  pkg.installed:
    - pkgs:
      - isync
      - opendkim
{% if grains['os_family'] == 'Debian' %}
      - opendkim-tools
{% endif %}
      - postfix
      - s-nail

/etc/postfix/main.cf:
  file.managed:
    - source: salt://mail/postfix_main.cf
    - template: jinja
    - mode: 644

/etc/postfix/tls_policy:
  file.managed:
    - source: salt://mail/postfix_tls_policy
    - template: jinja
    - mode: 600
  cmd.run:
    - name: postmap /etc/postfix/tls_policy
    - onchanges:
      - file: /etc/postfix/tls_policy
    - require:
      - pkg: mail_pkgs

/etc/postfix/sender_canonical:
  file.managed:
    - source: salt://mail/postfix_sender_canonical
    - template: jinja
    - mode: 600
  cmd.run:
    - name: postmap /etc/postfix/sender_canonical
    - onchanges:
      - file: /etc/postfix/sender_canonical
    - require:
      - pkg: mail_pkgs

/etc/postfix/header_checks:
  file.managed:
    - source: salt://mail/postfix_header_checks
    - template: jinja
    - mode: 600
  cmd.run:
    - name: postmap /etc/postfix/header_checks
    - onchanges:
      - file: /etc/postfix/header_checks
    - require:
      - pkg: mail_pkgs

postfix:
  service.running:
    - enable: True
    - watch:
      - file: /etc/postfix/main.cf
      - cmd: /etc/postfix/tls_policy
      - cmd: /etc/postfix/sender_canonical
      - cmd: /etc/postfix/header_checks
    - require:
      - pkg: mail_pkgs

{% if grains['os_family'] == 'Debian' %}
/etc/opendkim.conf:
{% else %}
/etc/opendkim/opendkim.conf:
{% endif %}
  file.managed:
    - source: salt://mail/opendkim.conf
    - template: jinja
    - mode: 644

/var/db/dkim:
  file.directory:
    - makedirs: True
    - user: opendkim
    - group: opendkim
    - require:
      - pkg: mail_pkgs

opendkim-genkey -r -s {{ grains['host'] }} -d {{ pillar['smtp_domain'] }} -D /var/db/dkim:
  cmd.run:
    - unless: test -f /var/db/dkim/{{ grains['host'] }}.private
    - require:
      - pkg: mail_pkgs

/var/db/dkim/{{ grains['host'] }}.private:
  file.managed:
    - user: opendkim
    - group: opendkim
    - mode: 600
    - create: False
    - replace: False
    - require:
      - pkg: mail_pkgs

opendkim:
  service.running:
    - enable: True
    - watch:
{% if grains['os_family'] == 'Debian' %}
      - file: /etc/opendkim.conf
{% else %}
      - file: /etc/opendkim/opendkim.conf
{% endif %}
    - require:
      - pkg: mail_pkgs

{% if grains['os_family'] == 'Debian' %}
/usr/bin/mail:
  file.managed:
    - source: salt://mail/mail
    - template: jinja
    - mode: 755

/usr/bin/mailx:
  file.symlink:
    - mode: 755
    - target: mail
{% endif %}

/etc/environment:
  file.managed:
    - source: salt://mail/environment
    - template: jinja
    - mode: 644
