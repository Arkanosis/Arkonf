fs_pkgs:
  pkg.installed:
    - pkgs:
      - gparted
      - exfat-utils
{% if grains['os_family'] != 'Arch' %}
      - nfs-common
{% else %}
      - nfs-utils
{% endif %}
      - ntfs-3g

{% if grains['mem_total'] > 7000 %}
/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - opts:
      - nodev
      - nosuid
{% if grains['mem_total'] > 32000 %}
      - size=10G
{% elif grains['mem_total'] > 24000 %}
      - size=8G
{% elif grains['mem_total'] > 16000 %}
      - size=6G
{% else %}
      - size=2G
{% endif %}
{% endif %}
