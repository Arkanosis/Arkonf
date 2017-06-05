irc_pkgs:
  pkg.installed:
    - pkgs:
      - weechat

/usr/bin/irc:
  file.managed:
    - source: salt://irc/irc
    - mode: 755
