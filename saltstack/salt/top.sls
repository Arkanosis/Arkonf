base:
  '*':
    - arkonf
    - compile
    - compression
    - crypto
    - document
    - emacs
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
#    - php
    - pidgin
    - publication
    - remmina
    - ruby
    - sound
    - sqlite
#    - synergy
    - sysvbanner
    - utilities
    - vim
    - vm
    - wammu

