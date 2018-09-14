profile_pkgs:
  pkg.installed:
    - pkgs:
      - kcachegrind
{% if grains['os_family'] == 'Arch' %}
      - linux-tools
{% else %}
      - linux-tools-generic
{% endif %}
      - valgrind
