network_pkgs:
  pkg.installed:
    - pkgs:
      - curl
      - goaccess
      - httpie
      - iftop
{% if grains['os_family'] != 'Arch' %}
      - iptables-persistent
{% endif %}
      #- knemo
      - mtr
      - nethogs
      - remmina
      - rsync
{% if grains['os_family'] != 'Arch' %}
      - smstools # TODO FIXME need smstools3 for ArchLinux as well
{% endif %}
      - traceroute
{% if grains['os_family'] != 'Arch' %}
      - usb-modeswitch
{% else %}
      - usb_modeswitch
{% endif %}
      - wammu
      - wget
      - whois
{% if grains['os_family'] == 'Arch' %}
      - wireshark-qt
{% else %}
      - wireshark
{% endif %}

/usr/bin/ethernet:
  file.managed:
    - source: salt://network/ethernet
    - mode: 755

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
