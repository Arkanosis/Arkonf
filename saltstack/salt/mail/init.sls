heirloom-mailx:
  pkg:
    - latest

mutt:
  pkg:
    - latest

ssmtp:
  pkg:
    - latest

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf
    - mode: 640

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - mode: 640
