communication_pkgs:
  pkg.installed:
    - pkgs:
      - pidgin
      - weechat

/usr/bin/irc:
  file.managed:
    - source: salt://chat/irc
    - mode: 755
