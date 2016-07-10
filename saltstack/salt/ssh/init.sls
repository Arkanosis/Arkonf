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
    - mode: 644

/etc/pam.d/sshd:
  file.managed:
    - source: salt://ssh/pam.d_sshd
    - mode: 644

/home/arkanosis/.ssh/config:
  file.symlink:
    - target: /home/arkanosis/Arkonf/ssh/.ssh/config
    - user: arkanosis
