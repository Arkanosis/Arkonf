profile_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - hyperfine
{% endif %}
      - kcachegrind
{% if grains['os_family'] == 'Arch' %}
      - linux-tools
{% else %}
      - linux-tools-generic
{% endif %}
      - valgrind

# AUR hotspot
