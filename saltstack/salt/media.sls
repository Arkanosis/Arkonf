media_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - ffmpeg
{% else %}
      - libav-tools
{% endif %}
      - vlc

dragonplayer:
  pkg:
    - removed

{% if grains['os_family'] == 'Debian' %}
/usr/bin/ffmpeg:
  file.symlink:
    - target: /usr/bin/avconv
{% endif %}
