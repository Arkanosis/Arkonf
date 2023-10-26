audio_pkgs:
  pkg.installed:
    - pkgs:
      #- ardour
      - audacity
{% if grains['os_family'] == 'Arch' %}
      - bluez-utils
      - easyeffects
{% endif %}
      - hydrogen
      - paprefs
      - pavucontrol
{% if grains['os_family'] == 'Arch' %}
      - pipewire
      - pipewire-alsa
      - pipewire-jack
      - pipewire-pulse
      - qpwgraph
      - wireplumber
{% else %}
      - pulseaudio
{% endif %}
      - rosegarden
