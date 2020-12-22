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
      - opusfile
      - opus-tools
      - mpv
{% if grains['os_family'] == 'Arch' %}
      - sdl2
      - sdl2_image
{% else %}
      - libsdl2
      - libsdl2-image
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
