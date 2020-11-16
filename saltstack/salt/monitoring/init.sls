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
      - lshw
      - lsof
{% if salt['grains.get']('gpus:vendor') == 'nvidia' %}
      - nvtop
{% endif %}
      - powertop
      - pv
{% if grains['virtual'] == 'physical' %}
      - smartmontools
{% endif %}
      - sysstat
      - strace
      - time

{% if grains['virtual'] == 'physical' %}
{% if grains['os_family'] == 'Arch' %}
smartd:
{% else %}
smartmontools:
{% endif %}
  service.running:
    - enable: True
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf
    - require:
      - pkg: monitoring_pkgs

{% for smart_drive in pillar['smart_drives'] %}
smartctl -s on /dev/{{ smart_drive }}:
  cmd.run:
    - onlyif: "smartctl -i /dev/{{ smart_drive }} | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endfor %}

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
{% endif %}
