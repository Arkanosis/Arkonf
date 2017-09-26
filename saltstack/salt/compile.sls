compile_pkgs:
  pkg.installed:
    - pkgs:
      - autoconf
      - cmake
{% if grains['os_family'] == 'Arch' %}
      - gcc
      - gettext
{% else %}
      - g++
      - autopoint # from gettext
{% endif %}
      - gdb
      - libtool
      - pkg-config
