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
    - kdiff3
    - image
    - monitoring
    - network
    - pass
    - processing
    - python
    - search
    - shell
    - space
    - ssh
    - term
    - usb
    - vcs
    - webbrowser
    - xorg

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
    - lsb
    - mail
    - media
#    - mysql-server
    - nginx
    - nfs
#    - php
    - pidgin
    - profile
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

