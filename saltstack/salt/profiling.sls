profile_pkgs:
  pkg.installed:
      - pkgs:
{% if grains['os_family'] == 'Arch' %}
        - hyperfine
{% endif %}
        - kcachegrind
{% if grains['os_family'] != 'Arch' %}
        - linux-tools-generic
{% endif %}
        - valgrind

{% if grains['os_family'] == 'Arch' %}
profile_pkgs_group:
  pkg.group_installed:
    - name:
      - linux-tools
{% endif %}

# AUR hotspot
