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
      - lm-sensors
      - lsof
      - smartmontools
      - sysstat
      - strace

smartmontools:
  service.running:
    - require:
      - pkg: monitoring_pkgs
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf

{% if grains['host'] in ['Cyclamen', 'Edelweiss'] %}
smartctl -s on /dev/sda:
  cmd.run:
    - onlyif: "smartctl -i /dev/sda | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endif %}

{% if grains['host'] in ['Cyclamen', 'Edelweiss'] %}
smartctl -s on /dev/sdb:
  cmd.run:
    - onlyif: "smartctl -i /dev/sdb | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endif %}

/etc/default/smartmontools:
  file.managed:
    - source: salt://monitoring/smartmontools-default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring_pkgs

/etc/smartd.conf:
  file.managed:
    - source: salt://monitoring/smartd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring_pkgs
