vm_pkgs:
  pkg.installed:
    - pkgs:
      - dnsmasq
{% if grains['os_family'] == 'Arch' %}
      - docker
{% else %}
      - docker.io
{% endif %}
      - lxc
{% if grains['os_family'] == 'Arch' %}
      - qemu-headless
{% else %}
      - qemu-kvm
{% endif %}
      - vkd3d
      - wine
      - winetricks

 # 32 bit libraries for Wine on Arch; not sure if it's really necessary
{% if grains['os_family'] == 'Arch' %}
arch_multilib:
  cmd.run:
    - name: 'echo "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf'
    - unless: grep -q '^\[multilib\]$' /etc/pacman.conf

vm_pkgs32:
  pkg.installed:
    - require:
      - cmd: arch_multilib
    - pkgs:
      - lib32-alsa-plugins
      - lib32-libpulse
      - lib32-libjpeg-turbo
      - lib32-libldap
      - lib32-libpng
      - lib32-gnutls
{% if salt['grains.get']('gpus:vendor') == 'intel' %}
      - lib32-mesa
{% endif %}
      - lib32-mpg123
      - lib32-vkd3d
      - lib32-vulkan-icd-loader
{% endif %}

{% if grains['os_family'] == 'Arch' %}
/etc/subuid:
  file.managed:
    - source: salt://vm/subuid
    - mode: 644

/etc/subgid:
  file.managed:
    - source: salt://vm/subgid
    - mode: 644

/etc/pam.d/system-login:
  cmd.run:
    - name: 'echo "session optional pam_cgfs.so -c freezer,memory,name=systemd,unified" >> /etc/pam.d/system-login'
    - unless: grep -q pam_cgfs /etc/pam.d/system-login

/etc/sysctl.d/userns.conf:
  cmd.run:
    - name: 'echo "kernel.unprivileged_userns_clone=1" >> /etc/sysctl.d/userns.conf'
    - unless: grep -q "kernel.unprivileged_userns_clone=1" /etc/sysctl.d/userns.conf

/etc/lxc/default.conf:
  file.managed:
    - source: salt://vm/default.conf
    - mode: 644

/etc/default/lxc-net:
  file.managed:
    - source: salt://vm/lxc-net
    - mode: 644
{% endif %}

/etc/lxc/lxc-usernet:
  file.managed:
    - source: salt://vm/lxc-usernet
    - mode: 644

{% for directory in ['/home/arkanosis', '/home/arkanosis/.local', '/home/arkanosis/.local/share'] %}
{{ directory }}:
  acl.present:
    - acl_type: user
    - acl_name: 100000
    - perms: x
{% endfor %}
