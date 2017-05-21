mutt:
  pkg:
    - latest

s-nail:
  pkg:
    - latest

ssmtp:
  pkg:
    - latest

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf
    - template: jinja
    - mode: 640

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - mode: 640
