mail_pkgs:
  pkg.installed:
    - pkgs:
      - isync
      - postfix
      - s-nail

/etc/postfix/main.cf:
  file.managed:
    - source: salt://mail/postfix_main.cf
    - template: jinja
    - mode: 644

/etc/postfix/passwd:
  file.managed:
    - source: salt://mail/postfix_passwd
    - template: jinja
    - mode: 600
  cmd.run:
    - name: postmap /etc/postfix/passwd
    - onchanges:
      - file: /etc/postfix/passwd
    - require:
      - pkg: mail_pkgs

/etc/postfix/generic:
  file.managed:
    - source: salt://mail/postfix_generic
    - template: jinja
    - mode: 600
  cmd.run:
    - name: postmap /etc/postfix/generic
    - onchanges:
      - file: /etc/postfix/generic
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
      - cmd: /etc/postfix/passwd
      - cmd: /etc/postfix/generic
      - cmd: /etc/postfix/header_checks
    - require:
      - pkg: mail_pkgs

{% if grains['os_family'] == 'Debian' %}
/usr/bin/mail:
  file.symlink:
    - user: root
    - mode: 755
    - target: s-nail

/usr/bin/mailx:
  file.symlink:
    - user: root
    - mode: 755
    - target: s-nail
{% endif %}
