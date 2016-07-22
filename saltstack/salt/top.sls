base:
  '*':
    - arkonf
    - emacs
    - network
    - fstab
    - monitoring
    - ssh
    - vcs
    - xorg
    - zsh

    - users

  'P@host:(marvin|taz)':
    - touchpad

  'G@gpus:vendor:intel':
    - match: grain
    - intel_gpu

  'G@os_family:Arch':
    - awesome

  'G@os_family:Debian':
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
    - vim
    - vm
    - wammu
    - xpra
