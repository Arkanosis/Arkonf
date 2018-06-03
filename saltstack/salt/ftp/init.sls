# TODO create users with login shell /usr/sbin/nologin
# TODO add /usr/sbin/nologin in /etc/shells

ftp_pkgs:
  pkg.installed:
    - pkgs:
      - filezilla
      - openssl
      - vsftpd

/etc/vsftpd.conf:
  file.managed:
    - source: salt://ftp/vsftpd.conf
    - mode: 644

/etc/vsftpd.allowed_users:
  file.managed:
    - source: salt://ftp/vsftpd.allowed_users
    - mode: 644

vsftpd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/vsftpd.conf
      - file: /etc/vsftpd.allowed_users
    - require:
      - pkg: ftp_pkgs
