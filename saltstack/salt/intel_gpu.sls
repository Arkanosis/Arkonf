intel_gpu_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - bbswitch
{% endif %}
      - xf86-video-intel
      - mesa-libgl
      - vulkan-intel
