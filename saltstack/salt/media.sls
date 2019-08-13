media_pkgs:
  pkg.installed:
    - pkgs:
      - asciinema
      - flac
{% if grains['os_family'] == 'Arch' %}
      - ffmpeg
      - libvdpau-va-gl
{% else %}
      - libav-tools
{% endif %}
      - opus-tools
      - mpv
      - v4l-utils
      - vlc

dragonplayer:
  pkg:
    - removed

{% if grains['os_family'] == 'Debian' %}
/usr/bin/ffmpeg:
  file.symlink:
    - target: /usr/bin/avconv
{% endif %}

git clone https://github.com/Arkanosis/tifoto.git /tmp/tifoto_installer && cd /tmp/tifoto_installer && ./install.sh:
  cmd.run:
    - unless: test -d /tmp/tifoto_installer
