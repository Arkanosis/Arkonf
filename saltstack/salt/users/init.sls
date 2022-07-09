{% if grains['virtual'] == 'physical' %}
users_mods:
  kmod.present:
    - mods:
      - dm_crypt
      - ecryptfs
{% endif %}

users_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['virtual'] == 'physical' %}
      - cryptsetup
      - ecryptfs-utils
{% endif %}
      - libpam-google-authenticator
      - qrencode
      - sudo

/etc/xdg/user-dirs.defaults:
  file.managed:
    - source: salt://users/user-dirs.defaults
    - user: root
    - group: root
    - mode: 644

/home/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{% for user in pillar['users'] %}

{% if user.login in pillar['local_users'] %}

{{ user.login }}:
  user.present:
    - fullname: {{ user.fullname | default('') }}
    - home: /home/{{ user.login }}
    - shell: {{ user.shell | default('/bin/bash') }}
    - system: {{ user.system | default(False) }}
    - uid: {{ user.id }}
    - gid: {{ user.id }}
{% if user.sudo | default(False) %}
    - groups:
{% if grains['os_family'] == 'Debian' %}
      - sudo
{% else %}
      - wheel
{% endif %}
{% endif %}
# TODO handle groups
    - remove_groups: False
    - require:
      - group: {{ user.login }}
  group.present:
    - gid: {{ user.id }}

/home/.ssh/{{ user.login }}:
  file.managed:
    - contents: {{ user.authorized_keys | default('') | yaml_encode }}
    - user: {{ user.login }}
    - group: {{ user.login }}
    - mode: 644
    - makedirs: True
    - require:
      - user: {{ user.login }}

/home/{{ user.login }}/.ssh/authorized_keys:
  file.symlink:
    - target: /home/.ssh/{{ user.login }}
    - user: {{ user.login }}
    - group: {{ user.login }}
    - mode: 644
    - makedirs: True
    - require:
      - user: {{ user.login }}

{% if pillar.encrypted_homes is defined and user.login in pillar['encrypted_homes'] %}
/home/.ecryptfs/{{ user.login }}:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd {{ user.login }}; ps -u {{ user.login }} && ecryptfs-migrate-home -u {{ user.login }}"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: {{ user.login }}
    - unless: test -d /home/.ecryptfs/{{ user.login }}
{% endif %}

{% if user.sftp | default(False) %}
/var/sftp/{{ user.login }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
{% endif %}

{% if user.linger | default(False) %}
/var/lib/systemd/linger/{{ user.login }}:
  file.managed:
    - makedirs: True
{% endif %}

{% if user.arkonf | default(False) %}
{{ user.login }}_arkonf:
  git.latest:
    - name: https://github.com/Arkanosis/Arkonf.git
    - rev: master
    - target: /home/{{ user.login }}/Arkonf
    - user: {{ user.login }}
    - unless: test -d /home/{{ user.login }}/Arkonf

rm -f /home/{{ user.login }}/.bashrc && rm -f /home/{{ user.login }}/.bash_profile:
  cmd.run:
    - require:
      - user: {{ user.login }}
    - unless: test -f /home/{{ user.login }}/.zshrc

make -C /home/{{ user.login }}/Arkonf install:
  cmd.run:
    - require:
      - user: {{ user.login }}
    - runas: {{ user.login }}
    - unless: test -f /home/{{ user.login }}/.zshrc
{% endif %}

# TODO enable local override
#  - ssh for asdp on Bismuth
#  - linger for Daniel on Cyclamen and Bruyere
#  - linger for Simonne on Bruyere

{% endif %}

{% endfor %}

/root/.ssh/authorized_keys:
  file.managed:
    - contents: {{ pillar['users'][0].authorized_keys | default('') | yaml_encode }}
    - mode: 644
    - makedirs: True

{% if grains['os_family'] == 'Arch' %}
/etc/sudoers:
  file.managed:
    - source: salt://users/sudoers
    - user: root
    - group: root
    - mode: 440
    - check-cmd: /usr/sbin/visudo -c -f
    - require:
      - pkg: users_pkgs

/etc/pam.d/system-auth:
  file.managed:
    - source: salt://users/system-auth
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: users_pkgs
{% endif %}

{% if pillar.encrypted_homes is defined %}
/etc/crypttab:
  cmd.run:
    - name: '! echo "Please run as root: ecryptfs-setup-swap"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
    - unless: grep -q cryptswap /etc/fstab
{% endif %}

/etc/shadow:
  file.managed:
    - mode: 640
