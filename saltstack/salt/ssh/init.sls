# TODO generate ssh keys

ssh_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - openssh
{% else %}
      - openssh-server
      - libpam-google-authenticator
{% endif %}
      - sshfs

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - mode: 644

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
