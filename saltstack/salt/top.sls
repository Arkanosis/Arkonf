base:
  '*':
    - arkonf
    - emacs
    - network
    - fstab
    - monitoring
    - ssh
    - xorg
    - zsh

    - users

  'gpus:vendor:intel':
    - match: grain
    - intel_gpu

  'os_family:Arch':
    - awesome

  'os_family:Debian':
#    - android
#    - apache2
    - aptitude
    - backup
    - bio
    - build
    - chromium
    - compression
    - containers
    - crypto
    - curl
    - dot
    - etckeeper
    - filezilla
    - firefox
    - g++
#    - gtalk
    - image
    - irc
    - java
    - kde
    - kdiff3
    - libreoffice
    - lsb
    - mail
    - media
#    - mysql-server
    - nginx
    - nfs
    - pass
#    - php
    - pidgin
    - publication
    - processing
    - python
    - remmina
    - ruby
    - sound
    - search
    - space
    - sqlite
#    - synergy
    - sysvbanner
    - term
    - utilities
    - vcs
    - vim
    - vm
    - wammu
    - xpra
