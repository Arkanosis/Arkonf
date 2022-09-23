media_pkgs:
  pkg.installed:
    - pkgs:
      - asciinema
      - flac
      - ffmpeg
{% if grains['os_family'] == 'Arch' %}
      - gpxsee
{% endif %}
      - kdenlive
{% if grains['os_family'] == 'Arch' %}
      - libvdpau-va-gl
      - linux-headers
{% else %}
      - linux-headers-amd64
{% endif %}
      - obs-studio
{% if grains['os_family'] == 'Arch' %}
      - opusfile
{% else %}
      - libopusfile0
{% endif %}
      - opus-tools
      - mpv
      - playerctl
{% if grains['os_family'] == 'Arch' %}
      - sdl2
      - sdl2_image
{% else %}
      - libsdl2-2.0-0
      - libsdl2-image-2.0-0
{% endif %}
      - v4l-utils
      - v4l2loopback-dkms
      - vlc
      - youtube-dl
      - zvbi

dragonplayer:
  pkg:
    - removed

git clone https://github.com/Arkanosis/tifoto.git /tmp/tifoto_installer && cd /tmp/tifoto_installer && ./install.sh:
  cmd.run:
    - unless: test -d /tmp/tifoto_installer
