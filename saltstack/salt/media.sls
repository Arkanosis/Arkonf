dragonplayer:
  pkg:
    - removed

libav-tools:
  pkg:
    - latest

vlc:
  pkg:
    - latest

/usr/bin/ffmpeg:
  file.symlink:
    - target: /usr/bin/avconv
