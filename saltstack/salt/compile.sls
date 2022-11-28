compile_pkgs:
  pkg.installed:
    - pkgs:
      - autoconf
      - bison
      - cmake
{% if grains['os_family'] == 'Arch' %}
      - eigen
{% else %}
      - eigen3
{% endif %}
      - elixir
      - flex
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
{% if grains['os_family'] == 'Arch' %}
      - pkgconf
      - qmk
      - rust-analyzer
      - rustup
      - rz-cutter
      - typescript
{% else %}
      - pkg-config
      - node-typescript
{% endif %}
