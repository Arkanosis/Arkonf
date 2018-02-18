containers_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] != 'Arch' %}
      -  docker.io
{% endif %}
      - lxc

/etc/lxc/lxc-usernet:
  file.managed:
    - source: salt://containers/lxc-usernet
    - mode: 644

/home/arkanosis/.config/lxc/default.conf:
  file.symlink:
    - target: /home/arkanosis/Arkonf/lxc/default.conf
    - user: arkanosis
    - makedirs: True

{% for directory in ['/home/arkanosis', '/home/arkanosis/.local', '/home/arkanosis/.local/share'] %}
{{ directory }}:
  acl.present:
    - acl_type: user
    - acl_name: 100000
    - perms: x
{% endfor %}
