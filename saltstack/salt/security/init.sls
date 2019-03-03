security_pkgs:
  pkg.installed:
    - pkgs:
      - cron-apt
      - fail2ban
      - logwatch
      - portsentry

fail2ban:
  service.running:
    - enable: True

portsentry:
  service.running:
    - enable: True

/etc/cron-apt/config:
  file.managed:
    - source: salt://security/cron-apt-config
    - template: jinja
    - mode: 755

/etc/cron-apt/action.d/3-download:
  file.managed:
    - source: salt://security/cron-apt-action-3-download
    - mode: 644

/etc/cron.daily/logwatch:
  file.managed:
    - source: salt://security/logwatch-cron
    - template: jinja
    - mode: 755

/etc/fail2ban/jail.local:
  file.managed:
    - source: salt://security/fail2ban-jail.local
    - template: jinja
    - mode: 644

/etc/portsentry/portsentry.ignore.static:
  file.managed:
    - source: salt://security/portsentry.ignore.static
    - template: jinja
    - mode: 644
