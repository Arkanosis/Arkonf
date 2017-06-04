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
      - traceroute
      - wget
      - whois
{% if grains['os_family'] == 'Arch' %}
      - wireshark-qt
{% else %}
      - wireshark
{% endif %}
