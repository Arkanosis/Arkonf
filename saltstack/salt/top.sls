base:
  '*':
    - arkonf
    - banner
    - containers
    - compile
    - compression
    - crypto
    - document
    - emacs
    - etckeeper
    - fstab
    - image
    - monitoring
    - network
    - pass
    - processing
    - python
    - search
    - space
    - ssh
    - term
    - usb
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
    - pacman

  'G@os_family:Debian':
#    - android
#    - apache2
    - aptitude
    - backup
    - bio
    - dot
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
#    - php
    - pidgin
    - publication
    - remmina
    - ruby
    - sound
    - sqlite
#    - synergy
    - utilities
    - vim
    - vm
    - wammu

