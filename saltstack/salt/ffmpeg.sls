libav-tools:
  pkg:
    - latest

/usr/bin/ffmpeg:
  file.symlink:
    - target: /usr/bin/avconv
