base:
  '*':
    - fstab
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
    - arkonf
    - backup
    - bio
    - build
    - chromium
    - compression
    - containers
    - crypto
    - curl
    - dot
    - emacs
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
    - monitoring
#    - mysql-server
    - network
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
