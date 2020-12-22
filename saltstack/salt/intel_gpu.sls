{% if grains['os_family'] == 'Arch' %}
intel_gpu_pkgs:
  pkg.installed:
    - pkgs:
      - bbswitch
      - xf86-video-intel
      - mesa-libgl
      - vulkan-intel
{% endif %}
