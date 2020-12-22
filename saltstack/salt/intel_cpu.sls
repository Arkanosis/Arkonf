intel_cpu_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - intel-ucode
{% else %}
      - intel-microcode
{% endif %}