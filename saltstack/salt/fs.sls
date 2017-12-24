fs_pkgs:
  pkg.installed:
    - pkgs:
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
{% else %}
      - size=2G
{% endif %}
{% endif %}
