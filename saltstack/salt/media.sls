media_pkgs:
  pkg.installed:
    - pkgs:
      - asciinema
      - flac
      - ffmpeg
{% if grains['os_family'] == 'Arch' %}
      - libvdpau-va-gl
{% endif %}
      - kdenlive
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
      - vlc
      - youtube-dl
      - zvbi

dragonplayer:
  pkg:
    - removed

git clone https://github.com/Arkanosis/tifoto.git /tmp/tifoto_installer && cd /tmp/tifoto_installer && ./install.sh:
  cmd.run:
    - unless: test -d /tmp/tifoto_installer
