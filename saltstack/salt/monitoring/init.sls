# TODO FIXME JRDS

monitoring_pkgs:
  pkg.installed:
    - pkgs:
      - dstat
      - glances
      - htop
{% if grains['os_family'] != 'Arch' %}
      - libncursesw5-dev
      - lm-sensors
{% else %}
      - lm_sensors
{% endif %}
      - lsof
      - powertop
      - pv
      - smartmontools
      - sysstat
      - strace
      - time

{% if grains['os_family'] == 'Arch' %}
smartd:
{% else %}
smartmontools:
{% endif %}
  service.running:
    - require:
      - pkg: monitoring_pkgs
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf

{% if grains['host'] in ['Cyclamen', 'Edelweiss', 'taz', 'marvin', 'Bruyere'] %}
smartctl -s on /dev/sda:
  cmd.run:
    - onlyif: "smartctl -i /dev/sda | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endif %}

{% if grains['host'] in ['Cyclamen', 'Edelweiss', 'Bruyere'] %}
smartctl -s on /dev/sdb:
  cmd.run:
    - onlyif: "smartctl -i /dev/sdb | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endif %}

{% if grains['host'] == 'Cyclamen' %}
smartctl -s on /dev/sdc:
  cmd.run:
    - onlyif: "smartctl -i /dev/sdc | grep -q 'SMART support is: Disabled'"
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
