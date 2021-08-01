{% if grains['os_family'] == 'Debian' %}
amd_gpu_pkgs:
  pkg.installed:
    - pkgs:
      - firmware-amd-graphics
      - xserver-xorg-video-ati
{% endif %}
