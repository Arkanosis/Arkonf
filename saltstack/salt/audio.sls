audio_pkgs:
  pkg.installed:
    - pkgs:
      #- ardour
      - audacity
      - hydrogen
      #- jackd
      - paprefs
      - pavucontrol
      - pulseaudio
{% if grains['os_family'] == 'Arch' %}
      - pulseaudio-alsa
      - pulseaudio-bluetooth
      - bluez-utils
{% endif %}
