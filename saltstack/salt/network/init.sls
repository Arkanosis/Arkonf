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
      - nethogs
      - rsync
{% if grains['os_family'] != 'Arch' %}
      - smstools # TODO FIXME need smstools3 for ArchLinux as well
{% endif %}
      - traceroute
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

/usr/bin/offline:
  file.managed:
    - source: salt://network/offline
    - mode: 755

/usr/bin/wifi:
  file.managed:
    - source: salt://network/wifi
    - mode: 755
