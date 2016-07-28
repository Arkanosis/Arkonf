# TODO FIXME JRDS

monitoring_pkgs:
  pkg.installed:
    - pkgs:
      - dstat
      - glances
      - htop
{% if grains['os_family'] != 'Arch' %}
      - libncursesw5-dev
{% endif %}
      - lsof
      - sysstat
      - strace
