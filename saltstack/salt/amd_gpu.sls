{% if grains['os_family'] == 'Debian' %}
amd_gpu_pkgs:
  pkg.installed:
    - pkgs:
      - firmware-amd-graphics
      - xserver-xorg-video-ati
{% elif grains['os_family'] == 'Arch' %}
amd_gpu_pkgs:
  pkg.installed:
    - pkgs:
      - vulkan-radeon
{% endif %}
