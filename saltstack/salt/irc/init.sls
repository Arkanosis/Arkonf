weechat:
  pkg:
    - latest

/usr/bin/irc:
  file.managed:
    - source: salt://irc/irc
    - mode: 755
