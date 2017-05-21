mail_pkgs:
  pkg.installed:
    - pkgs:
      - mutt
      - s-nail
      - ssmtp

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf
    - template: jinja
    - mode: 640

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - mode: 640
