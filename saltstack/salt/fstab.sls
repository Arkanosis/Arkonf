/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - opts:
      - nodev
      - nosuid
      - size=10G
