fs_pkgs:
  pkg.installed:
    - pkgs:
      - gparted
      - exfatprogs
      - ntfs-3g

{% if grains['mem_total'] > 7000 %}
/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - opts:
      - nodev
      - nosuid
{% if grains['mem_total'] > 31000 %}
      - size=10G
{% elif grains['mem_total'] > 23000 %}
      - size=8G
{% elif grains['mem_total'] > 15000 %}
      - size=6G
{% else %}
      - size=2G
{% endif %}
{% endif %}
