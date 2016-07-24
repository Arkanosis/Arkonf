base:
  '*':
    - arkonf
    - compile
    - compression
    - crypto
    - emacs
    - fstab
    - image
    - libreoffice
    - monitoring
    - network
    - space
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
    - intel_gpu

  'G@os_family:Arch':
    - awesome

  'G@os_family:Debian':
#    - android
#    - apache2
    - aptitude
    - backup
    - bio
    - containers
    - dot
    - etckeeper
    - filezilla
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
    - sqlite
#    - synergy
    - sysvbanner
    - utilities
    - vim
    - vm
    - wammu
    - xpra
