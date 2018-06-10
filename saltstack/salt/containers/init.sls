containers_pkgs:
  pkg.installed:
    - pkgs:
      - dnsmasq
{% if grains['os_family'] == 'Arch' %}
      - docker
{% endif %}
      - docker.io
{% endif %}
      - lxc

{% if grains['os_family'] != 'Arch' %}
/etc/subuid:
  file.managed:
    - source: salt://containers/subuid
    - mode: 644

/etc/subgid:
  file.managed:
    - source: salt://containers/subgid
    - mode: 644

/etc/pam.d/system-login:
  cmd.run:
    - name: 'echo "session optional pam_cgfs.so -c freezer,memory,name=systemd,unified" >> /etc/pam.d/system-login'
    - unless: grep -q pam_cgfs /etc/pam.d/system-login

/etc/lxc/default.conf:
  file.managed:
    - source: salt://containers/default.conf
    - mode: 644

/etc/default/lxc-net:
  file.managed:
    - source: salt://containers/lxc-net
    - mode: 644
{% endif %}

/etc/lxc/lxc-usernet:
  file.managed:
    - source: salt://containers/lxc-usernet
    - mode: 644

{% for directory in ['/home/arkanosis', '/home/arkanosis/.local', '/home/arkanosis/.local/share'] %}
{{ directory }}:
  acl.present:
    - acl_type: user
    - acl_name: 100000
    - perms: x
{% endfor %}
