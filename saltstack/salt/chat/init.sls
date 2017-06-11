chat_pkgs:
  pkg.installed:
    - pkgs:
      - pidgin
      - weechat

/usr/bin/irc:
  file.managed:
    - source: salt://irc/irc
    - mode: 755
