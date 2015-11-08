# TODO names in UTF-8
# TODO user emails
# TODO user pictures (KDM)
# TODO use ecryptfs for home directories

include:
  - zsh

famille:
  group.present:
    - gid: 1100

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
    #- fullname: "Jérémie Roquet"
    - shell: /usr/bin/zsh
    - home: /home/arkanosis
    - uid: 1000
    - gid: 1000
    - groups:
      - dialout # access to /dev/tty* for (g|w)ammu
      - docker
      - famille
      - amis
    - remove_groups: False
    - require:
      - pkg: zsh
  group.present:
    - gid: 1000

snad:
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
      - pkg: zsh
  group.present:
    - gid: 1101
snad_a:
  group.present:
    - gid: 1102
    - members:
      - arkanosis
      - snad

oodna:
  user.present:
    #- fullname: "Anne-Sophie Denommé-Pichon"
    - shell: /usr/bin/zsh
    - home: /home/oodna
    - uid: 1201
    - gid: 1201
    - groups:
      - famille
      - amis
    - remove_groups: False
    - require:
      - pkg: zsh
  group.present:
    - gid: 1201
oodna_a:
  group.present:
    - gid: 1202
    - members:
      - arkanosis
      - oodna

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
      - pkg: zsh
  group.present:
    - gid: 1203
albinou_a:
  group.present:
    - gid: 1204
    - members:
      - arkanosis
      - albinou
