network_pkgs:
  pkg.installed:
    - pkgs:
      - iftop
{% if grains['os_family'] != 'Arch' %}
      - iptables-persistent
{% endif %}
      #- knemo
      - nethogs
      - traceroute
      - wget
      - whois
{% if grains['os_family'] == 'Arch' %}
      - wireshark-qt
{% else %}
      - wireshark
{% endif %}
