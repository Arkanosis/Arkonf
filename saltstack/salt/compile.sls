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
{% if grains['os_family'] == 'Arch' %}
      - go
      - go-tools
{% else %}
      - golang-go
      - golang-golang-x-tools
{% endif %}
      - libtool
{% if grains['os_family'] == 'Arch' %}
      - namcap
{% endif %}
      - pkg-config
{% if grains['os_family'] == 'Arch' %}
      - rustup
      - typescript
{% else %}
      - node-typescript
{% endif %}
