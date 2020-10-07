# TODO generate ssh keys

ssh_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - openssh
      - putty
{% else %}
      - openssh-server
      - putty-tools
{% endif %}
      - sshfs

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - mode: 644

/usr/bin/notify_ssh_login:
  file.managed:
    - source: salt://ssh/notify_ssh_login
    - template: jinja
    - mode: 755

/etc/pam.d/sshd:
  file.managed:
{% if grains['os_family'] == 'Arch' %}
    - source: salt://ssh/pam.d_sshd.arch
{% else %}
    - source: salt://ssh/pam.d_sshd
{% endif %}
    - mode: 644

{% if grains['os_family'] == 'Arch' %}
sshd:
{% else %}
ssh:
{% endif %}
  service.running:
    - enable: True
    - watch:
      - file: /etc/ssh/sshd_config
      - file: /etc/pam.d/sshd
    - require:
      - pkg: ssh_pkgs
