base:
  '*':
    - arkonf
    - compression
    - crypto
    - emacs
    - fstab
    - image
    - libreoffice
    - monitoring
    - network
    - ssh
    - term
    - vcs
    - webbrowser
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
    - containers
    - dot
    - etckeeper
    - filezilla
    - g++
#    - gtalk
    - irc
    - java
    - kde
    - kdiff3
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
    - utilities
    - vim
    - vm
    - wammu
    - xpra
