network_pkgs:
  pkg.installed:
    - pkgs:
      - curl
{% if grains['os_family'] == 'Arch' %}
      - dog
{% endif %}
      - filezilla
{% if grains['os_family'] == 'Arch' %}
      - gammu
{% endif %}
      - goaccess
      - httpie
      - iftop
      - iperf3
{% if grains['os_family'] != 'Arch' %}
      - iptables-persistent
{% endif %}
      #- kdeconnect
      #- knemo
      - mitmproxy
      - mtr
      - nebula
      - nethogs
      - nmap
{% if grains['os_family'] == 'Arch' %}
      - openbsd-netcat
{% else %}
      - netcat-openbsd
{% endif %}
      #- qrcp
      - remmina
      - rsync
{% if grains['os_family'] != 'Arch' %}
      - smstools # TODO FIXME need smstools3 for ArchLinux as well
{% endif %}
      - speedtest-cli
      - traceroute
{% if grains['os_family'] == 'Arch' %}
      - usb_modeswitch
{% else %}
      - usb-modeswitch
{% endif %}
      - wget
      - whois
{% if grains['os_family'] == 'Arch' %}
      - wireshark-cli
      - wireshark-qt
{% else %}
      - wireshark
{% endif %}

{% if pillar.network_interfaces is defined %}
{% if pillar.network_interfaces.wired is defined %}
{% for network_interface in pillar['network_interfaces']['wired'] %}
/usr/bin/ethernet:
  file.managed:
    - source: salt://network/ethernet
    - template: jinja
    - defaults:
        network_interface: {{ network_interface }}
    - mode: 755

/etc/systemd/network/10-dhcp-{{ network_interface }}.network:
  file.managed:
    - source: salt://network/dhcp.network
    - template: jinja
    - defaults:
        network_interface: {{ network_interface }}
    - mode: 644
{% endfor %}
{% endif %}
{% endif %}

/usr/bin/lte:
  file.managed:
    - source: salt://network/lte
    - mode: 755

/usr/bin/offline:
  file.managed:
    - source: salt://network/offline
    - mode: 755

/usr/bin/wifi:
  file.managed:
    - source: salt://network/wifi
    - mode: 755

/usr/bin/assistance:
  file.managed:
    - source: salt://network/assistance
    - mode: 755

{% if pillar.network_interfaces is defined %}
{% if pillar.network_interfaces.wireless is defined %}
{% for network_interface in pillar['network_interfaces']['wireless'] %}
wpa_supplicant@{{ network_interface }}:
  service.running:
    - enable: True

/etc/systemd/network/10-dhcp-{{ network_interface }}.network:
  file.managed:
    - source: salt://network/dhcp.network
    - template: jinja
    - defaults:
        network_interface: {{ network_interface }}
    - mode: 644
{% endfor %}
{% endif %}
{% endif %}

systemd-networkd:
  service.running:
    - enable: True

{% if grains['os_family'] == 'Arch' %}
/etc/systemd/resolved.conf:
  file.managed:
    - source: salt://network/resolved.conf
    - mode: 644

/etc/resolv.conf:
  file.symlink:
    - target: /run/systemd/resolve/stub-resolv.conf
    - force: True
    - backupname: /etc/resolv.conf.bak

systemd-resolved:
  service.running:
    - enable: True
{% endif %}

/usr/lib/systemd/system/nebula.service:
  file.managed:
    - source: salt://network/nebula.service
    - mode: 644

/etc/nebula:
  file.directory:
    - user: nebula
    - group: nebula
    - mode: 700
    - makedirs: True
    - require:
      - user: nebula

# TODO FIXME set lighthouse.am_lighthouse and lighthouse.hosts correctly on the lighthouses
/etc/nebula/config.yml:
  file.managed:
    - source: salt://network/nebula-config.yml
    - mode: 644

nebula:
  user.present:
    - system: True
    - shell: /bin/false
    - uid: 899
    - gid: 899
    - groups:
      - nebula
    - require:
      - group: nebula
  group.present:
    - system: True
    - gid: 899
  service.running:
    - enable: True
    - require:
      - user: nebula
