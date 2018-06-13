# TODO names in UTF-8
# TODO user emails
# TODO user pictures (KDM)
# TODO guest home on tmpfs

include:
{% if grains['os_family'] != 'Arch' %}
  - containers
  - ssh
{% endif %}
  - monitoring
  - network
  - shell

{% if grains['os_family'] == 'Arch' %}
users_mods:
  kmod.present:
    - mods:
      - dm_crypt
      - ecryptfs
{% endif %}

users_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - ecryptfs-utils
{% endif %}
      - sudo

# TODO FIXME same gid everywhere for famille (ie. 1004, as 1100 doesn't own anything anywhere AFAIR)
{% if grains['host'] in ['Cyclamen', 'Bruyere'] %}
famille:
  group.present:
    - gid: 1004
{% elif grains['host'] in ['Edelweiss', 'taz', 'marvin'] %}
famille:
  group.present:
    - gid: 1100
{% endif %}

amis:
  group.present:
    - gid: 1200

sshbridge:
  user.present:
    - shell: /bin/false
    - home: /home/sshbridge
    - uid: 900
    - gid: 900
    - remove_groups: False
  group.present:
    - gid: 900

arkanosis:
  user.present:
    #- fullname: 'Jérémie Roquet'
    - shell: /usr/bin/zsh
    - home: /home/arkanosis
    - uid: 1000
    - gid: 1000
    - groups:
{% if grains['os_family'] != 'Arch' %}
      - dialout # access to /dev/tty* for (g|w)ammu
      - docker
{% endif %}
{% if grains['os_family'] == 'Arch' %}
      - wheel
{% endif %}
      - famille
      - amis
    - remove_groups: False
    - require:
{% if grains['os_family'] != 'Arch' %}
      - pkg: containers_pkgs
{% endif %}
      - pkg: shell_pkgs
  group.present:
    - gid: 1000

/var/lib/systemd/linger/arkanosis:
  file.managed:
    - makedirs: True

{% if grains['os_family'] == 'Arch' %}
/home/.ecryptfs/arkanosis:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd arkanosis; ps -u arkanosis && ecryptfs-migrate-home -u arkanosis"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: arkanosis
    - unless: test -d /home/.ecryptfs/arkanosis
{% endif %}

git@github.com:Arkanosis/Arkonf.git:
  git.latest:
    - rev: master
    - target: /home/arkanosis/Arkonf
    - user: arkanosis

make -C /home/arkanosis/Arkonf install:
  cmd.run:
    - require:
      - pkg: users_pkgs
      - user: arkanosis
    - unless: test -d /home/arkanosis/.zshrc

{% if grains['host'] == 'Cyclamen' %}
Sandrine:
  user.present:
    - fullname: Sandrine Roquet
    - shell: /usr/bin/zsh
    - home: /home/Sandrine
    - uid: 1001
    - gid: 1001
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1001
{% endif %}

{% if grains['host'] in ['Cyclamen', 'Bruyere'] %}
Daniel:
  user.present:
    - fullname: Daniel Roquet
    - shell: /usr/bin/zsh
    - home: /home/Daniel
    - uid: 1002
    - gid: 1002
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1002

/var/lib/systemd/linger/Daniel:
  file.managed:
    - makedirs: True
{% endif %}

{% if grains['host'] == 'Cyclamen' %}
Annette:
  user.present:
    - fullname: Annette Menguy
    - shell: /usr/bin/zsh
    - home: /home/Annette
    - uid: 1003
    - gid: 1003
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1003
{% endif %}

{% if grains['host'] != 'Bruyere' %}
snad: # TODO FIXME replace with Sandrine above
  user.present:
    - fullname: Sandrine Roquet
    - shell: /usr/bin/zsh
    - home: /home/snad
    - uid: 1101
    - gid: 1101
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1101
snad_a:
  group.present:
    - gid: 1102
    - members:
      - arkanosis
      - snad

{% if grains['os_family'] == 'Arch' %}
/home/.ecryptfs/snad:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd snad; ps -u snad && ecryptfs-migrate-home -u snad"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: snad
    - unless: test -d /home/.ecryptfs/snad
{% endif %}
{% endif %}

{% if grains['host'] == 'Bruyere' %}
Simonne:
  user.present:
    - fullname: Simonne Roquet
    - shell: /usr/bin/zsh
    - home: /home/Simonne
    - uid: 1005
    - gid: 1005
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1005

/var/lib/systemd/linger/Simonne:
  file.managed:
    - makedirs: True
{% endif %}

{% if grains['host'] == 'Bruyere' %}
Marie-Christine:
  user.present:
    #- fullname: Marie-Christine Tréfond
    - shell: /usr/bin/zsh
    - home: /home/Marie-Chrisine
    - uid: 1006
    - gid: 1006
    - groups:
      - famille
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1006
{% endif %}

{% if grains['host'] != 'Bruyere' %}
oodna:
  user.present:
    #- fullname: 'Anne-Sophie Denommé-Pichon'
    - shell: /usr/bin/zsh
    - home: /home/oodna
    - uid: 1201
    - gid: 1201
    - groups:
      - famille
      - amis
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1201
oodna_a:
  group.present:
    - gid: 1202
    - members:
      - arkanosis
      - oodna

{% if grains['os_family'] == 'Arch' %}
/home/.ecryptfs/oodna:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd oodna; ps -u oodna && ecryptfs-migrate-home -u oodna"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: oodna
    - unless: test -d /home/.ecryptfs/oodna
{% endif %}
{% endif %}

{% if grains['host'] != 'Bruyere' %}
albinou:
  user.present:
    - fullname: Albin Kauffmann
    - shell: /usr/bin/zsh
    - home: /home/albinou
    - uid: 1203
    - gid: 1203
    - groups:
      - amis
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1203
albinou_a:
  group.present:
    - gid: 1204
    - members:
      - arkanosis
      - albinou


{% if grains['os_family'] == 'Arch' %}
/home/.ecryptfs/albinou:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd albinou; ps -u albinou && ecryptfs-migrate-home -u albinou"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: albinou
    - unless: test -d /home/.ecryptfs/albinou
{% endif %}
{% endif %}

guest:
  user.present:
    #- fullname: 'Guest'
    - shell: /usr/bin/zsh
    - home: /home/guest
    - uid: 1900
    - gid: 1900
    - groups:
    - remove_groups: False
    - require:
      - pkg: shell_pkgs
  group.present:
    - gid: 1900

{% if grains['os_family'] == 'Arch' %}
/home/.ecryptfs/guest:
  cmd.run:
    - name: '! echo "Please run as root and then login: passwd guest; ps -u guest && ecryptfs-migrate-home -u guest"'
    - require:
      - kmod: users_mods
      - pkg: users_pkgs
      - user: guest
    - unless: test -d /home/.ecryptfs/guest
{% endif %}

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

{% if grains['os_family'] == 'Arch' %}
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
