# TODO generate ssh keys

ssh_pkgs:
  pkg.installed:
    - pkgs:
      - libpam-google-authenticator
{% if grains['os_family'] == 'Arch' %}
      - openssh
{% else %}
      - openssh-server
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

{% if grains['os_family'] != 'Arch' %}
/etc/pam.d/sshd:
  file.managed:
    - source: salt://ssh/pam.d_sshd
    - mode: 644
{% endif %}

{% if grains['os_family'] == 'Arch' %}
sshd.socket:
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
